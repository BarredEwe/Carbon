import Foundation

public typealias ItemClosure<Item: Component> = (ActionContent<Item>) -> Void

public struct ItemAction<Item: Component>: Hashable {

    var value: ItemClosure<Item>

    public static func == (lhs: ItemAction, rhs: ItemAction) -> Bool {
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
}
