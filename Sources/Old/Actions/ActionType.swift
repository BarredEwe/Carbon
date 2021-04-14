import Foundation

public typealias CustomActionType = String

/// Description of action types
public enum ActionType: RawRepresentable, Hashable {

    case select
    case didLoad
    case custom(CustomActionType)

    // MARK: RawRepresentable
    public typealias RawValue = String

    public init?(rawValue: String) {
        return nil
    }

    public var rawValue: String {
        switch self {
        case let .custom(item): return item
        default: return String(describing: self)
        }
    }
}
