import UIKit

public struct ShadowView<View: IdentifiableComponent>: DecorationView {
    public let id: View.ID
    public let view: View
    public let radius: CGFloat
    public let opacity: Float
    public let offset: CGSize
    public let color: UIColor

    public init(id: View.ID, view: View, radius: CGFloat, opacity: Float = 1, offset: CGSize = .zero, color: UIColor) {
        self.id = id
        self.view = view
        self.radius = radius
        self.opacity = opacity
        self.offset = offset
        self.color = color
    }

    public func prepare(content: UIView) {
        content.clipsToBounds = false
        content.layer.shadowColor = color.cgColor
        content.layer.shadowOpacity = opacity
        content.layer.shadowOffset = offset
        content.layer.shadowRadius = radius
    }
}
