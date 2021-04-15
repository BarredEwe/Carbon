import UIKit

public struct WrapperUIView<View: ActionableView>: ActionableComponent {
    public var id: String
    public var view: View

    public init(id: String? = nil, view: View) {
        self.id = id ?? (view as? NSObject)?.description ?? "WrapperUIView"
        self.view = view
    }

    public func renderContent() -> View {
        view
    }

    public func render(in content: View) {}

    public func layout(content: View, in container: UIView) {
        guard let content = content as? UIView else { return }
        content.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(content)

        content.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        content.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        content.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        content.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
    }

    public func intrinsicContentSize(for content: View) -> CGSize {
        (content as? UIView)?.intrinsicContentSize ?? .zero
    }

    public static func == (lhs: WrapperUIView<View>, rhs: WrapperUIView<View>) -> Bool {
        lhs.id != rhs.id || lhs.shouldContentUpdate(with: rhs)
    }
}
