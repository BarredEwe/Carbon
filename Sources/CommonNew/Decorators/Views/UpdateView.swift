import UIKit

public struct UpdateView<View: IdentifiableComponent>: DecorationView {
    public let id: View.ID
    public let view: View
    public let update: (inout View.Content) -> Void

    public init(id: View.ID, view: View, _ update: @escaping (inout View.Content) -> Void) {
        self.id = id
        self.view = view
        self.update = update
    }

    public func render(in content: View.Content) {
        var content = content
        update(&content)
        view.render(in: content)
    }

    public static func == (lhs: UpdateView<View>, rhs: UpdateView<View>) -> Bool {
        lhs.id == rhs.id && lhs.shouldContentUpdate(with: rhs)
    }
}
