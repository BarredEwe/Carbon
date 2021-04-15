import UIKit

public struct TableAppearanceView<View: IdentifiableComponent>: DecorationView {
    public typealias AccessoryView = UIView

    public let id: View.ID
    public let view: View

    public let accessoryType: UITableViewCell.AccessoryType
    public let accessoryView: AccessoryView?
    public let selectionStyle: UITableViewCell.SelectionStyle
    public let tintColor: UIColor?

    public init(id: View.ID,
                view: View,
                accessoryType: UITableViewCell.AccessoryType = .none,
                accessoryView: AccessoryView? = nil,
                selectStyle: UITableViewCell.SelectionStyle = .none,
                tintColor: UIColor? = nil) {
        self.id = id
        self.view = view
        self.accessoryType = accessoryType
        self.accessoryView = accessoryView
        self.selectionStyle = selectStyle
        self.tintColor = tintColor
    }

    public func prepare(content: UIView) {
        guard let componentCell = content.superview(as: UITableViewCell.self) else { return }
        componentCell.accessoryType = accessoryType
        componentCell.accessoryView = accessoryView
        componentCell.tintColor = tintColor ?? componentCell.tintColor
        componentCell.selectionStyle = selectionStyle
    }
}
