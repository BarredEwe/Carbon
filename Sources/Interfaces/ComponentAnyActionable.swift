/// Type erased Protocol allowing to trigger a typed event on a component
public protocol ComponentAnyActionable {
    func call(_ action: AnyActionContent, in actions: [ActionType: Any])
}
