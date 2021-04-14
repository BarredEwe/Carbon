import Carbon

public typealias Action<View: ActionableComponent> = (View, View.Content.ItemInfo) -> ()

public struct ActionView<View: ActionableComponent>: DecorationView {
    public let id: View.ID
    public var view: View { actionDelegate.view }
    private let actionDelegate: ActionDelegate<View>

    public init(id: View.ID, view: View, action: View.Content.Action, completion: @escaping Action<View>) {
        self.id = id
        actionDelegate = ActionDelegate(view: view)
        actionDelegate.append(completion: completion, for: action)
    }

    public func render(in content: View.Content) {
        view.render(in: content)
        content.actionDelegate = actionDelegate
    }

    public func layout(content: View.Content, in container: UIView) {
        view.layout(content: content, in: container)
    }

    public func on(action: View.Content.Action, completion: @escaping Action<View>) -> ActionView<View> {
        actionDelegate.append(completion: completion, for: action)
        return self
    }

    public func on(action: View.Content.Action, completion: @escaping () -> ()) -> ActionView<View> {
        actionDelegate.append(completion: { _, _ in completion() }, for: action)
        return self
    }
}
