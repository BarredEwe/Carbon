import Carbon

public struct StackView: IdentifiableComponent {
    public let id: String
    public let axis: NSLayoutConstraint.Axis
    public let alignment: UIStackView.Alignment
    public let distribution: UIStackView.Distribution
    public let spacing: CGFloat
    public let components: [AnyComponent]

    public init(id: String,
                axis: NSLayoutConstraint.Axis,
                alignment: UIStackView.Alignment,
                distribution: UIStackView.Distribution,
                spacing: CGFloat,
                components: [AnyComponent]) {
        self.id = id
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        self.components = components
    }

    public func renderContent() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = spacing

        return stackView
    }

    public func render(in content: UIStackView) {
        let reuseIds: Set<String> = Set(components.map { $0.reuseIdentifier })
        content.wrappers.lazy
            .filter { !reuseIds.contains($0.reuseId) }
            .forEach { $0.removeFromSuperview() }
        components.forEach { component in
            let wrapper: SVWrapper
            if let _wrapper = content.wrappers.first(where: { $0.reuseId == component.reuseIdentifier }) {
                wrapper = _wrapper
            } else if let view = component.renderContent() as? UIView {
                wrapper = SVWrapper(reuseId: component.reuseIdentifier, view: view)
                content.addArrangedSubview(wrapper)
                component.layout(content: view, in: wrapper)
            } else {
                assertionFailure("Component.Content must be inherited from UIView")
                return
            }
            component.render(in: wrapper.view)
        }
    }

    public func shouldContentUpdate(with next: StackView) -> Bool {
        self != next
    }
}

private class SVWrapper: UIView {
    let reuseId: String
    let view: UIView

    required init(reuseId: String, view: UIView) {
        self.reuseId = reuseId
        self.view = view
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension UIStackView {
    var wrappers: [SVWrapper] {
        subviews.compactMap { $0 as? SVWrapper }
    }
}
