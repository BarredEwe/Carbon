/// Represents a component that can be uniquely identify.
///
/// Example for the simple identified component:
///
///     struct UserLabel: IdentifiableComponent {
///         var id: Int64
///         var name: String
///
///         func renderContent() -> UILabel {
///             return UILabel()
///         }
///
///         func render(in content: UILabel) {
///             content.text = name
///         }
///     }
public protocol IdentifiableComponent: Component, CellsBuildable {
    /// A type that represents an id that used to uniquely identify the component.
    associatedtype ID: Hashable

    /// An identifier that used to uniquely identify the component.
    var id: ID { get }
}

public extension IdentifiableComponent {
    /// Build an array of section.
    func buildCells() -> [CellNode] {
        return [CellNode(self)]
    }

    func needChange(for action: AnyActionContent) -> AnyComponent? {
        guard let contentView = action.view as? Content else { return nil }
        let component = didChange(with: ActionContent(view: contentView, object: self, indexPath: action.indexPath,
            userInfo: action.userInfo, type: action.type))
        return AnyComponent(component)
    }

    /// Adding an action to a specific type of Action
    /// - Parameters:
    ///   - action: Specific type of Action
    ///   - closure: Сlosure with parameters caused by a specific action
    /// - Returns: NodeComponent
    @inlinable
    func on(_ action: ActionType, _ closure: @escaping ItemClosure<Self>) -> NodeComponent<Self> {
        return NodeComponent(component: self)
            .on(action, closure)
    }

    /// Adding an action to a specific type of Action
    /// - Parameters:
    ///   - action: Specific type of Action
    ///   - closure: Сlosure without parameters caused by a specific action
    /// - Returns: NodeComponent
    @inlinable
    func on(_ action: ActionType, _ closure: @escaping () -> Void) -> NodeComponent<Self> {
        return NodeComponent(component: self)
            .on(action, { _ in closure() })
    }

    /// Typed node with saved actions
    var nodeComponent: NodeComponent<Self> {
        return NodeComponent(component: self)
    }

    @inlinable
    var cellNode: CellNode {
        return CellNode(self)
    }

    @inlinable
    var viewNode: ViewNode {
        return ViewNode(self)
    }
}

public extension IdentifiableComponent where Self: Hashable {
    /// An identifier that can be used to uniquely identify the component.
    /// Default is `self`.
    var id: Self {
        return self
    }
}
