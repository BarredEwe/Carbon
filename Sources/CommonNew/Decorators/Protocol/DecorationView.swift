import Carbon

public protocol DecorationView: IdentifiableComponent {
    associatedtype View: IdentifiableComponent
    typealias Content = View.Content

    var view: View { get }

    func prepare(content: UIView)
}

public extension DecorationView {

    var reuseIdentifier: String {
        String(reflecting: Self.self)
    }

    func renderContent() -> Content {
        view.renderContent()
    }

    func render() -> Content {
        let container = UIView()
        let viewContent = view.renderContent()
        view.render(in: viewContent)

        let content = renderContent()
        layout(content: content, in: container)
        render(in: content)
        return content
    }

    func render(in content: Content) {
        (content as? UIView).flatMap(prepare)
        view.render(in: content)
    }

    func layout(content: Content, in container: UIView) {
        view.layout(content: content, in: container)
    }

    func shouldContentUpdate(with next: Self) -> Bool {
        self != next || view.shouldContentUpdate(with: next.view)
    }

    func shouldRender(next: Self, in content: Content) -> Bool {
        self != next || view.shouldRender(next: view, in: content)
    }

    func referenceSize(in bounds: CGRect) -> CGSize? {
        view.referenceSize(in: bounds)
    }

    func intrinsicContentSize(for content: Content) -> CGSize {
        view.intrinsicContentSize(for: content)
    }

    func prepare(content: UIView) {
        assertionFailure("Its necessary to implement!!")
    }
}
