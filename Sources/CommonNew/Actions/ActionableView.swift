import UIKit

public protocol ActionableView: AnyObject {
    associatedtype Action: Hashable
    associatedtype Item: ActionableComponent
    associatedtype ItemInfo = Void

    var actionDelegate: ActionDelegate<Item>? { get set }
}

private var AssociatedObjectHandle: UInt8 = 0

public extension ActionableView {
    var actionDelegate: ActionDelegate<Item>? {
        get {
            objc_getAssociatedObject(self, &AssociatedObjectHandle) as? ActionDelegate<Item>
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
