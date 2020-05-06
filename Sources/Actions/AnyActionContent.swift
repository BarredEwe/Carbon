import Foundation

/// Type erased action content
public struct AnyActionContent {

    public var componentId: AnyHashable? {
        return component?.as(ComponentUpdater.self)?.componentCellNode?.id
    }
    public var view: UIView
    public var component: AnyComponent?
    public var type: ActionType
    /// UITableView or UICollectionView
    public var target: UIView?
    public var indexPath: IndexPath?
    public var userInfo: [AnyHashable: Any]?

    public init(view: UIView, component: AnyComponent? = nil, type: ActionType, target: UIView? = nil,
                  indexPath: IndexPath? = nil, userInfo: [AnyHashable : Any]? = nil) {
        self.view = view
        self.component = component
        self.type = type
        self.target = target
        self.indexPath = indexPath
        self.userInfo = userInfo
    }
}

