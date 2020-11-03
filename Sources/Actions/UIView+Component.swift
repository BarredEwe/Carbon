import UIKit

private var associateComponentKey: Void?

internal extension UIView {
    var component: CellNode? {
        get {
            objc_getAssociatedObject(self, &associateComponentKey) as? CellNode
        }
        set {
            objc_setAssociatedObject(self, &associateComponentKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

public extension NodeComponent {
    func render() -> T.Content {
        let content = component.render()
        (content as? UIView)?.component = cellNode
        return content
    }
}

public extension IdentifiableComponent {
    func render() -> Content {
        let view = renderContent()
        render(in: view)
        return view
    }
}
