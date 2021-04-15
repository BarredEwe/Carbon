import UIKit

public struct SpacerView: IdentifiableComponent {
    public let id: String
    public let width: CGFloat?
    public let height: CGFloat?

    public func renderContent() -> SpacerViewContent {
        SpacerViewContent()
    }

    public func render(in content: SpacerViewContent) {
        width.flatMap(content.widthAnchor.constraint(equalToConstant:))?.isActive = true
        height.flatMap(content.heightAnchor.constraint(equalToConstant:))?.isActive = true
    }
}

public class SpacerViewContent: UIView {}
