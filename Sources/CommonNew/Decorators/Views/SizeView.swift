import UIKit

public struct SizeView<View: IdentifiableComponent>: DecorationView {
    public let id: View.ID
    public let view: View
    public let size: CGSize

    public init(id: View.ID, view: View, size: CGSize) {
        self.id = id
        self.view = view
        self.size = size
    }

    public func prepare(content: UIView) {
        if let hConstraint = content.constraints.first(where: { $0.firstAnchor == content.heightAnchor }),
           let wConstraint = content.constraints.first(where: { $0.firstAnchor == content.widthAnchor }) {
            hConstraint.constant = size.height
            wConstraint.constant = size.width
        } else {
            content.heightAnchor.constraint(equalToConstant: size.height).isActive = true
            content.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
}
