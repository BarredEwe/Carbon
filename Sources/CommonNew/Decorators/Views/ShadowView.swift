import Carbon

public struct ShadowView<View: IdentifiableComponent>: DecorationView {
    public let id: View.ID
    public let view: View
    public let radius: CGFloat
    public let color: UIColor

    public init(id: View.ID, view: View, radius: CGFloat, color: UIColor) {
        self.id = id
        self.view = view
        self.radius = radius
        self.color = color
    }

    public func prepare(content: UIView) {
        content.clipsToBounds = false
        content.layer.shadowColor = color.cgColor
        content.layer.shadowOpacity = 1
        content.layer.shadowOffset = .zero
        content.layer.shadowRadius = radius
    }
}
