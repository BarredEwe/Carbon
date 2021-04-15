import UIKit

extension UIView {
    func superview<T>(as type: T.Type) -> T? {
        if let type = self as? T {
            return type
        } else if let type = superview as? T {
            return type
        }
        return superview?.superview(as: type)
    }
}
