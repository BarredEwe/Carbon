import UIKit

public struct WrapperView<View: IdentifiableComponent>: IdentifiableComponent {
    public let id: View.ID
    public let view: View

    public init(id: View.ID, view: View) {
        self.id = id
        self.view = view
    }

    public func renderContent() -> WrapperViewContent {
        WrapperViewContent()
    }

    public func render(in content: WrapperViewContent) {
        if let cell = content.superview as? UITableViewComponentCell {
            if cell.reuseIdentifier != reuseIdentifier {
                return
            }
        }
        guard let viewContent = content.subviews.first as? View.Content else { return }
        view.render(in: viewContent)
    }

    public func layout(content: WrapperViewContent, in container: UIView) {
        content.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(content)

        content.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        content.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        content.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        content.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true

        let viewContent = view.renderContent()
        view.layout(content: viewContent, in: content)
        view.render(in: viewContent)
    }
}

public class WrapperViewContent: UIView {}
