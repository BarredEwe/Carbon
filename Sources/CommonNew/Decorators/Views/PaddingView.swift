import UIKit

public struct PaddingView<View: IdentifiableComponent>: DecorationView {
    public let id: View.ID
    public let view: View

    public var top: CGFloat?
    public var left: CGFloat?
    public var bottom: CGFloat?
    public var right: CGFloat?

    public init(id: View.ID, view: View, top: CGFloat? = nil, bottom: CGFloat? = nil, left: CGFloat? = nil, right: CGFloat? = nil) {
        self.id = id
        self.view = view
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
    }

    public func prepare(content: UIView) {
        guard let container = content.superview else { return }
        if let top = top {
            container.constraints.first { $0.firstAnchor == content.topAnchor }?.constant = top
        }
        if let bottom = bottom {
            container.constraints.first { $0.firstAnchor == content.bottomAnchor }?.constant = -bottom
        }
        if let left = left {
            container.constraints.first { $0.firstAnchor == content.leadingAnchor }?.constant = left
        }
        if let right = right {
            container.constraints.first { $0.firstAnchor == content.trailingAnchor }?.constant = -right
        }
    }
}
