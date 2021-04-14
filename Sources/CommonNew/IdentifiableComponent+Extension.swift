public extension IdentifiableComponent where Self: Equatable {
    @inlinable
    func size(_ size: CGSize) -> SizeView<Self> {
        SizeView(id: id, view: self, size: size)
    }

    @inlinable
    func insets(_ insets: UIEdgeInsets) -> InsetsView<Self> {
        InsetsView(id: id, view: self, insets: insets)
    }

    @inlinable
    func shadow(_ radius: CGFloat, color: UIColor) -> ShadowView<Self> {
        ShadowView(id: id, view: self, radius: radius, color: color)
    }

    @inlinable
    func height(_ height: CGFloat) -> HeightView<Self> {
        HeightView(id: id, view: self, height: height)
    }

    @inlinable
    func wrap() -> WrapperView<Self> {
        WrapperView(id: id, view: self)
    }

    @inlinable
    func set<T: Equatable>(_ keyPath: WritableKeyPath<Self.Content, T>, value: T) -> KeyPathView<Self, T> {
        KeyPathView(id: id, view: self, keyPath: keyPath, value: value)
    }

    @inlinable
    func on(action: DefaultAction, _ completion: @escaping () -> ()) -> SelectView<Self> {
        switch action {
        case .select:
            return SelectView(id: id, view: self, completion: completion)
        }
    }
}

public extension ActionableComponent {
    @inlinable
    func on(action: Content.Action, completion: @escaping Action<Self>) -> ActionView<Self> {
        ActionView(id: id, view: self, action: action, completion: completion)
    }

    @inlinable
    func on(action: Content.Action, completion: @escaping () -> ()) -> ActionView<Self> {
        ActionView(id: id, view: self, action: action, completion: { _, _ in completion() })
    }
}
