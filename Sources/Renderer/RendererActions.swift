import UIKit

public protocol RendererActions: class {

    /// Returns a current data held in adapter.
    /// When data is set, it renders to the target immediately.
    var data: [Section] { get set }

    /// The delegate reporting any actions in the nodes
    var actionsDelegate: ActionsDelegate? { get set }

    /// Render given collection of sections, immediately.
    ///
    /// - Parameters:
    ///   - data: A collection of sections to be rendered.
    func render<C: Collection>(_ data: C) where C.Element == Section

    /// Render given collection of sections skipping nil, immediately.
    ///
    /// - Parameters:
    ///   - data: A collection of sections to be rendered that can be contains nil.
    func render<C: Collection>(_ data: C) where C.Element == Section?

    /// Render given collection sections, immediately.
    ///
    /// - Parameters:
    ///   - data: A variadic number of sections to be rendered.
    func render(_ data: Section...)

    /// Render given variadic number of sections skipping nil, immediately.
    ///
    /// - Parameters:
    ///   - data: A variadic number of sections to be rendered that can be contains nil.
    func render(_ data: Section?...)

    /// Render given variadic number of sections with function builder syntax, immediately.
    ///
    /// - Parameters:
    ///   - sections: A closure that constructs sections.
    func render<S: SectionsBuildable>(@SectionsBuilder sections: () -> S)

    /// Render a single section contains given cells with function builder syntax, immediately.
    ///
    /// - Parameters:
    ///   - cells: A closure that constructs cells.
    func render<C: CellsBuildable>(@CellsBuilder cells: () -> C)
}
