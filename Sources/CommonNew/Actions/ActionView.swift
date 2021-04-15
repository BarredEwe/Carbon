import Carbon

public typealias ActionCompletion<View: ActionableComponent> = (View, View.Content.ItemInfo) -> ()

public struct ActionView<View: ActionableComponent>: DecorationView {
    public let id: View.ID
    public var view: View { actionDelegate.view }
    private let actionDelegate: ActionDelegate<View>

    public init(id: View.ID, view: View, action: View.Content.Action, completion: @escaping ActionCompletion<View>) {
        self.id = id
        actionDelegate = ActionDelegate(view: view)
        actionDelegate.append(completion: completion, for: action)
        addAction(action, completion: completion)
    }

    public func render(in content: View.Content) {
        view.render(in: content)
        content.actionDelegate = (actionDelegate as? ActionDelegate<View.Content.Item>)
    }

    public func layout(content: View.Content, in container: UIView) {
        view.layout(content: content, in: container)
    }

    public func on(action: View.Content.Action, completion: @escaping ActionCompletion<View>) -> ActionView<View> {
        actionDelegate.append(completion: completion, for: action)
        addAction(action, completion: completion)
        return self
    }

    public func on(action: View.Content.Action, completion: @escaping () -> ()) -> ActionView<View> {
        actionDelegate.append(completion: { _, _ in completion() }, for: action)
        addAction(action, completion: { _, _ in completion() })
        return self
    }

    // MARK: Private Methods
    private func addAction(_ action: View.Content.Action, completion: @escaping ActionCompletion<View>) {
        if let action = action as? UIControl.Event,
           let info = Void() as? View.Content.ItemInfo,
           let control = (Mirror(reflecting: view).children.first(where: { $0.label == "view" })?.value as? UIView)
            .flatMap { Mirror(reflecting: $0).children.first?.value as? UIControl } {
            control.addAction(for: action) { completion(view, info) }
        }
    }
}


extension UIControl {
    func addAction(for controlEvents: UIControl.Event, _ closure: @escaping () -> Void) {
        @objc class ClosureSleeve: NSObject {
            let closure: () -> Void

            init(_ closure: @escaping () -> Void) {
                self.closure = closure
            }

            @objc func invoke() {
                closure()
            }
        }

        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(ObjectIdentifier(self).hashValue) + String(controlEvents.rawValue),
                                 sleeve,
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
