import UIKit

/// Renderer is a controller to render passed data to target
/// immediately using specific adapter and updater.
///
/// Its behavior can be changed by using other type of adapter,
/// updater, or by customizing it.
///
/// Example for render a section containing simple nodes.
///
///     let tableView: UITableView = ...
///     let renderer = Renderer(
///         adapter: UITableViewAdapter(),
///         updater: UITableViewUpdater()
///     )
///
///     renderer.target = tableView
///
///     renderer.render {
///         Label("Cell 1")
///             .identified(by: \.text)
///
///         Label("Cell 2")
///             .identified(by: \.text)
///
///         Label("Cell 3")
///             .identified(by: \.text)
///     }
open class Renderer<Updater: Carbon.Updater> {
    /// An instance of adapter that specified at initialized.
    public let adapter: Updater.Adapter

    /// An instance of updater that specified at initialized.
    public let updater: Updater

    /// An instance of target that weakly referenced.
    /// It will be passed to the `prepare` method of updater at didSet.
    open weak var target: Updater.Target? {
        didSet {
            guard let target = target else { return }
            updater.prepare(target: target, adapter: adapter)
        }
    }

    public weak var actionsDelegate: ActionsDelegate?

    open var data: [Section] {
        get { return adapter.data }
        set(data) { render(data) }
    }

    /// Create a new instance with given adapter and updater.
    public init(adapter: Updater.Adapter, updater: Updater, actionsDelegate: ActionsDelegate? = nil) {
        self.adapter = adapter
        self.updater = updater
        self.actionsDelegate = actionsDelegate
        self.adapter.renderer = self
    }

    public convenience init(adapter: Updater.Adapter, updater: Updater, target: Updater.Target?) {
        self.init(adapter: adapter, updater: updater)
        self.target = target
    }
}

extension Renderer: RendererActions {

    open func render<C: Collection>(_ data: C) where C.Element == Section {
        let data = Array(data)

        guard let target = target else {
            adapter.data = data
            return
        }

        updater.performUpdates(target: target, adapter: adapter, data: data)
    }

    open func render<C: Collection>(_ data: C) where C.Element == Section? {
        render(data.compactMap { $0 })
    }

    open func render(_ data: Section...) {
        render(data)
    }

    open func render(_ data: Section?...) {
        render(data.compactMap { $0 })
    }

    open func render<S: SectionsBuildable>(@SectionsBuilder sections: () -> S) {
        render(sections().buildSections())
    }

    open func render<C: CellsBuildable>(@CellsBuilder cells: () -> C) {
        render {
            Section(id: UniqueIdentifier(), cells: cells)
        }
    }
}

private struct UniqueIdentifier: Hashable {}
