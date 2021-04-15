import UIKit

public struct InsetsView<View: IdentifiableComponent>: DecorationView {
    public let id: View.ID
    public let view: View
    public let insets: UIEdgeInsets

    public init(id: View.ID, view: View, insets: UIEdgeInsets) {
        self.id = id
        self.view = view
        self.insets = insets
    }

    public func prepare(content: UIView) {
        guard let container = content.superview else { return }

        container.constraints.first { $0.secondAnchor == content.topAnchor  }?.constant = -insets.top
        container.constraints.first { $0.secondAnchor == content.bottomAnchor }?.constant = -insets.bottom
        container.constraints.first { $0.secondAnchor == content.leadingAnchor }?.constant = -insets.left
        container.constraints.first { $0.secondAnchor == content.trailingAnchor }?.constant = -insets.right

        container.constraints.first { $0.firstAnchor == content.topAnchor  }?.constant = insets.top
        container.constraints.first { $0.firstAnchor == content.bottomAnchor }?.constant = insets.bottom
        container.constraints.first { $0.firstAnchor == content.leadingAnchor }?.constant = insets.left
        container.constraints.first { $0.firstAnchor == content.trailingAnchor }?.constant = insets.right
    }
}
