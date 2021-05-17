public extension IdentifiableComponent where Self: Equatable {
    @inlinable
    func size(width: CGFloat, height: CGFloat) -> SizeView<Self> {
        SizeView(id: id, view: self, size: .init(width: width, height: height))
    }

    @inlinable
    func insets(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> InsetsView<Self> {
        InsetsView(id: id, view: self, top: top, bottom: bottom, left: left, right: right)
    }

    @inlinable
    func padding(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> PaddingView<Self> {
        PaddingView(id: id, view: self, top: top, bottom: bottom, left: left, right: right)
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
    func cellAppearance(accessoryType: UITableViewCell.AccessoryType = .none,
                        accessoryView: AccessoryView? = nil,
                        selectStyle: UITableViewCell.SelectionStyle = .none,
                        tintColor: UIColor? = nil,
                        separatorInset: UIEdgeInsets? = nil) -> TableAppearanceView<Self> {
        TableAppearanceView(id: id,
                            view: self,
                            accessoryType: accessoryType,
                            accessoryView: accessoryView,
                            selectStyle: selectStyle,
                            tintColor: tintColor,
                            separatorInset: separatorInset)
    }

    @inlinable
    func on(action: DefaultAction, _ completion: @escaping () -> ()) -> SelectView<Self> {
        on(action: action, { _, _ in completion() })
    }

    @inlinable
    func on(action: DefaultAction, _ completion: @escaping (Self, Self.Content) -> ()) -> SelectView<Self> {
        switch action {
        case .select:
            return SelectView(id: id, view: self, completion: completion)
        }
    }
}

public extension ActionableComponent {
    @inlinable
    func on(action: Content.Action, completion: @escaping ActionCompletion<Self>) -> ActionView<Self> {
        ActionView(id: id, view: self, action: action, completion: completion)
    }

    @inlinable
    func on(action: Content.Action, completion: @escaping () -> ()) -> ActionView<Self> {
        ActionView(id: id, view: self, action: action, completion: { _, _ in completion() })
    }
}

public extension IdentifiableComponent {
    @inlinable
    func cornerRadius(_ radius: CGFloat) -> UpdateView<Self> {
        UpdateView(id: id, view: self) {
            (($0 as? UIView) ?? ($0 as? ActionViewWrapper<UIView>)?.view)?.layer.cornerRadius = radius
        }
    }

    @inlinable
    func background(_ color: UIColor) -> UpdateView<Self> {
        UpdateView(id: id, view: self) {
            (($0 as? UIView) ?? ($0 as? ActionViewWrapper<UIView>)?.view)?.backgroundColor = color
        }
    }
}

public extension IdentifiableComponent where Self.Content == ActionViewWrapper<UILabel> {
    @inlinable
    func font(_ font: UIFont) -> UpdateView<Self> {
        UpdateView(id: id, view: self) {
            $0.view.font = font
        }
    }

    @inlinable
    func text(_ string: String?) -> UpdateView<Self> {
        UpdateView(id: id, view: self) {
            $0.view.text = string
        }
    }

    @inlinable
    func lines(_ number: Int) -> UpdateView<Self> {
        UpdateView(id: id, view: self) {
            $0.view.numberOfLines = number
        }
    }

    @inlinable
    func foregroundColor(_ color: UIColor) -> UpdateView<Self> {
        UpdateView(id: id, view: self) {
            $0.view.textColor = color
        }
    }
}

public extension IdentifiableComponent where Self.Content == ActionViewWrapper<UIButton> {
    @inlinable
    func text(_ string: String?) -> UpdateView<Self> {
        UpdateView(id: id, view: self) {
            $0.view.setTitle(string, for: .normal)
        }
    }

    @inlinable
    func foregroundColor(_ color: UIColor) -> UpdateView<Self> {
        UpdateView(id: id, view: self) {
            $0.view.setTitleColor(color, for: .normal)
        }
    }
}
