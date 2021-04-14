import Carbon

public struct SpacerView: IdentifiableComponent {
    public let id: String
    public let width: CGFloat?
    public let height: CGFloat?

    public func renderContent() -> SpacerViewContent {
        SpacerViewContent()
    }

    public func render(in content: SpacerViewContent) {
        width.flatMap { content.widthAnchor.constraint(equalToConstant: $0).isActive = true }
        height.flatMap { content.heightAnchor.constraint(equalToConstant: $0).isActive = true }
    }
}

public class SpacerViewContent: UIView {}
