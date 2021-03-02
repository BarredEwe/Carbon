import Foundation

/// Typed node with saved actions
public class NodeComponent<T: IdentifiableComponent> {

    /// Represents a component that can be uniquely identify.
    public var component: T

    /// Dictionary of actions by type
    private var actions = [ActionType: ItemAction<T>]()

    public init(component: T) {
        self.component = component
    }

    /// Adding an action to a specific type of Action
    /// - Parameters:
    ///   - action: Specific type of Action
    ///   - closure: Сlosure with parameters caused by a specific action
    /// - Returns: NodeComponent
    public func on(_ action: ActionType, _ closure: @escaping ItemClosure<T>) -> Self {
        actions[action] = ItemAction<T>(value: closure)
        return self
    }

    /// Adding an action to a specific type of Action
    /// - Parameters:
    ///   - action: Specific type of Action
    ///   - closure: Сlosure without parameters caused by a specific action
    /// - Returns: NodeComponent
    public func on(_ action: ActionType, _ closure: @escaping () -> Void) -> Self {
        actions[action] = ItemAction<T>(value: { _ in closure() })
        return self
    }

    /// Returns a `Bool` value indicating whether the content should be reloaded.
    ///
    /// - Note: Unlike `Equatable`, this doesn't compare whether the two values
    ///         exactly equal. It's can be ignore property comparisons, if not expect
    ///         to reload content.
    ///
    /// - Parameter:
    ///   - next: The next value to be compared to the receiver.
    ///
    /// - Returns: A `Bool` value indicating whether the content should be reloaded.
    @inlinable
    public func shouldContentUpdate(with next: T) -> Bool {
        return component.shouldContentUpdate(with: next)
    }

    public var cellNode: CellNode {
        let cellNode = CellNode(component)
        cellNode.actions = actions
        return cellNode
    }

    public var viewNode: ViewNode {
        let viewNode = ViewNode(component)
        viewNode.actions = actions
        return viewNode
    }
}

extension NodeComponent: CellsBuildable {
    public func buildCells() -> [CellNode] {
        [cellNode]
    }
}
