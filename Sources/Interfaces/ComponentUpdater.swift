/// Provides an interface for requesting component changes by action
public protocol ComponentUpdater {

    /// Requests content update
    /// - Parameter action: Provides general information about the event.
    func needChange(for action: AnyActionContent) -> AnyComponent?

    var componentViewNode: ViewNode? { get }
    var componentCellNode: CellNode? { get }
}

public extension ComponentUpdater {

    @inlinable
    var componentViewNode: ViewNode? {
        return nil
    }

    @inlinable
    var componentCellNode: CellNode? {
        return nil
    }

    func needChange(for action: AnyActionContent) -> AnyComponent? {
        return nil
    }

    @inlinable
    static var typeIdentificator: String {
        return String(describing: self)
    }

    @inlinable
    var typeIdentificator: String {
        return type(of: self).typeIdentificator
    }

    @inlinable
    func createComponent() -> AnyComponent? {
        return nil
    }
}

public extension ComponentUpdater where Self: IdentifiableComponent {

    @inlinable
    var componentViewNode: ViewNode? {
        return ViewNode(self)
    }

    @inlinable
    var componentCellNode: CellNode? {
        return CellNode(self)
    }
}

public extension ComponentUpdater where Self: Component {
    @inlinable
    func createComponent() -> AnyComponent? {
        return AnyComponent(self)
    }
}
