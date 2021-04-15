import UIKit

public protocol ActionableComponent: IdentifiableComponent where Content: ActionableView {
    func needChange(for action: Content.Action, info: Content.ItemInfo) -> Self?
}

public extension ActionableComponent {
    func needChange(for action: Content.Action, info: Content.ItemInfo) -> Self? {
        nil
    }
}
