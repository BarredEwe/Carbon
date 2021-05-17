import UIKit

public struct SelectView<View: IdentifiableComponent>: DecorationView {
    public let id: View.ID
    public let view: View

    private let tapRecognizer: UITapGestureRecognizer

    public init(id: View.ID, view: View, completion: @escaping (View, View.Content) -> ()) {
        self.id = id
        self.view = view
        tapRecognizer = BindableGestureRecognizer { content in
            guard let content = content as? View.Content else { return }
            completion(view, content)
        }
    }

    public func prepare(content: UIView) {
        content.addGestureRecognizer(tapRecognizer)
    }

    public static func == (lhs: SelectView<View>, rhs: SelectView<View>) -> Bool {
        lhs.view == rhs.view
    }
}
