import Foundation

/// Complete action information
public struct ActionContent<Item: Component> {

    public let view: Item.Content
    public let object: Item
    public let indexPath: IndexPath?
    public let userInfo: [AnyHashable: Any]?
    public let type: ActionType

    public init(view: Item.Content, object: Item, indexPath: IndexPath?, userInfo: [AnyHashable: Any]?, type: ActionType) {
        self.view = view
        self.object = object
        self.indexPath = indexPath
        self.userInfo = userInfo
        self.type = type
    }
}
