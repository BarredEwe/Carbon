import UIKit

public protocol Wrappable {}

extension UIControl.Event: Hashable {}

public extension Wrappable {

    public var actionView: ActionViewWrapper<Self> {
        ActionViewWrapper<Self>(view: self)
    }

    public var wrapperView: WrapperUIView<ActionViewWrapper<Self>> {
        WrapperUIView(view: actionView)
    }
}

extension UIView: Wrappable {}

extension UIView: CellsBuildable {
    public var cellNode: CellNode {
        wrapperView.cellNode
    }

    public func buildCells() -> [CellNode] {
        [cellNode]
    }
}

public class ActionViewWrapper<View>: UIView, ActionableView {
    public var view: View

    public typealias Action = UIControl.Event
    public typealias Item = WrapperUIView<ActionViewWrapper>

    public init(view: View) {
        self.view = view
        super.init(frame: .zero)

        guard let content = view as? UIView else { return }
        content.translatesAutoresizingMaskIntoConstraints = false
        addSubview(content)

        content.topAnchor.constraint(equalTo: topAnchor).isActive = true
        content.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        content.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        content.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

