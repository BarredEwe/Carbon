import UIKit

public protocol Wrappable {}

public extension Wrappable {
    @inlinable
    public var actionView: ActionViewWrapper<Self> {
        ActionViewWrapper<Self>(view: self)
    }

    @inlinable
    public var wrapperView: WrapperUIView<ActionViewWrapper<Self>> {
        WrapperUIView(view: actionView)
    }

    @inlinable
    public func wrapperView(_ id: String?) -> WrapperUIView<ActionViewWrapper<Self>> {
        WrapperUIView(id: id, view: actionView)
    }
}

extension UIControl.Event: Hashable {}

extension UIView: Wrappable {}

extension UIView: CellsBuildable {
    @inlinable
    public var cellNode: CellNode {
        wrapperView.cellNode
    }

    @inlinable
    public func buildCells() -> [CellNode] {
        [cellNode]
    }
}
