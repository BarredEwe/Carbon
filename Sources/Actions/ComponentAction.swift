import Foundation

public class ComponentAction {

    /// Content view for component
    public let view: UIView
    /// Type of action taken
    public let actionType: ActionType
    /// Any additional information for action
    public let userInfo: [AnyHashable: Any]?

    public init(_ actionType: ActionType, sender: UIView, userInfo: [AnyHashable: Any]? = nil) {
        self.actionType = actionType
        self.view = sender
        self.userInfo = userInfo
    }

    /// Starting action processing
    @inlinable
    open func invoke() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "CarbonNotifications.CellAction"), object: self, userInfo: userInfo)
    }
}
