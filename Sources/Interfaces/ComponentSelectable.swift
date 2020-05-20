import UIKit

public typealias AccessoryView = UIView

/// Provides the ability to implement a response to selection
public protocol ComponentSelectable {
    var accessoryType: UITableViewCell.AccessoryType { get }
    var accessoryView: AccessoryView? { get }
    var selectionStyle: UITableViewCell.SelectionStyle { get }
    var tintColor: UIColor? { get }

    func didSelect(with view: UIView, at indexPath: IndexPath?)
}

public extension ComponentSelectable {
    var accessoryType: UITableViewCell.AccessoryType { return .none }
    var accessoryView: AccessoryView? { return nil }
    var selectionStyle: UITableViewCell.SelectionStyle { return .none }
    var tintColor: UIColor? { return .systemBlue }

    func didSelect(with view: UIView, at indexPath: IndexPath? = nil) {
        didSelect(with: view, at: indexPath)
    }
}
