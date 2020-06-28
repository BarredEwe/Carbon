import UIKit

public typealias AccessoryView = UIView

/// Provides the ability to implement a response to selection
public protocol ComponentAppearance {
    var accessoryType: UITableViewCell.AccessoryType { get set }
    var accessoryView: AccessoryView? { get set }
    var selectionStyle: UITableViewCell.SelectionStyle { get set }
    var tintColor: UIColor? { get set }

    func didSelect(with view: UIView, at indexPath: IndexPath?)
}

public extension ComponentAppearance {
    var accessoryType: UITableViewCell.AccessoryType {
        get { return .none }
        set { }
    }
    var accessoryView: AccessoryView? {
        get { return nil }
        set { }
    }
    var selectionStyle: UITableViewCell.SelectionStyle {
        get { return .none }
        set { }
    }
    var tintColor: UIColor? {
        get { return nil }
        set { }
    }

    func didSelect(with view: UIView, at indexPath: IndexPath? = nil) {
        didSelect(with: view, at: indexPath)
    }
}
