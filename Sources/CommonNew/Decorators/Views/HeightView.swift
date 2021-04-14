import Carbon

public struct HeightView<View: IdentifiableComponent>: DecorationView {
    public let id: View.ID
    public let view: View
    public let height: CGFloat

    public init(id: View.ID, view: View, height: CGFloat) {
        self.id = id
        self.view = view
        self.height = height
    }

    public func prepare(content: UIView) {
        if let constraint = content.constraints.first(where: { $0.firstAnchor == content.heightAnchor }) {
            constraint.constant = height
        } else {
            content.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
