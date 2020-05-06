import Foundation

/// The delegate reporting any actions in the nodes
public protocol ActionsDelegate: class {
    func did(action: AnyActionContent)
}
