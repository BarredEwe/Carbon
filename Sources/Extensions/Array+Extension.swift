import Foundation

public extension Array where Element == Section {

    /// Updating the IdentifiableComponent object according to the passed indexPath
    /// - Parameters:
    ///   - node: IdentifiableComponent object
    ///   - indexPath: IndexPath by which node should be updated
    /// - Complexity: O(1)
    @inlinable
    mutating func update<Component: IdentifiableComponent>(component: Component?, for indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        switch indexPath.row {
        case IndexPath.headerComponentIndex: self[safe: indexPath.section]?.header = component?.viewNode
        case IndexPath.footerComponentIndex: self[safe: indexPath.section]?.footer = component?.viewNode
        default: self[safe: indexPath.section]?.cells[safe: indexPath.row] = component?.cellNode
        }
    }

    /// Updating the CellNode object according to the passed indexPath
    /// - Parameters:
    ///   - node: CellNode object
    ///   - indexPath: IndexPath by which node should be updated
    /// - Complexity: O(1)
    @inlinable
    mutating func update(node: CellNode?, for indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        self[safe: indexPath.section]?.cells[safe: indexPath.row] = node
    }

    /// Updating the ViewNode of an object according to the passed indexPath
    /// - Parameters:
    ///   - node: ViewNode object
    ///   - indexPath: IndexPath by which node should be updated
    /// - Complexity: O(1)
    @inlinable
    mutating func update(node: ViewNode?, for indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        switch indexPath.row {
        case IndexPath.headerComponentIndex: self[safe: indexPath.section]?.header = node
        case IndexPath.footerComponentIndex: self[safe: indexPath.section]?.footer = node
        default: return
        }
    }

    /// Updating AnyComponent object according to the passed indexPath
    /// - Parameters:
    ///   - node: AnyComponent object
    ///   - indexPath: IndexPath by which node should be updated
    /// - Complexity: O(1)
    @inlinable
    mutating func update(anyComponent: AnyComponent?, for indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        switch indexPath.row {
        case IndexPath.headerComponentIndex, IndexPath.footerComponentIndex:
            let node = anyComponent?.as(ComponentUpdater.self)?.componentViewNode
            if let actions = viewNode(for: indexPath)?.actions { node?.actions = actions }
            update(node: node, for: indexPath)
        default:
            let node = anyComponent?.as(ComponentUpdater.self)?.componentCellNode
            if let actions = self[safe: indexPath.section]?.cells[safe: indexPath.row]?.actions { node?.actions = actions }
            update(node: node, for: indexPath)
        }
    }

    /// Removing a CellNode object by the passed indexPath
    /// - Parameter indexPath: IndexPath by which node should be deleted
    @inlinable
    mutating func removeNode(for indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        self[safe: indexPath.section]?.cells.remove(at: indexPath.row)
    }

    /// Insert a CellNode object according to the passed indexPath
    /// - Parameters:
    ///   - node: CellNode объект
    ///   - indexPath: ndexPath, по которому должен вставиться node
    @inlinable
    mutating func insert(node: CellNode, for indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        self[safe: indexPath.section]?.cells.insert(node, at: indexPath.row)
    }

    /// Search for an item by id
    /// - Parameter id: id item
    /// - Complexity: O(n*m), where *n* is the length of the collection sections, and where m* is the length of the collection cells
    @inlinable
    func component<Type: Hashable>(for id: Type) -> AnyComponent? {
        return compactMap { section in
            section.cells.first(where: { cell in (cell.id as? Type) == id })
        }.first?.component
    }

    /// Search for an item by indexPath
    /// - Parameter indexPath: indexPath item
    @inlinable
    func component(for indexPath: IndexPath) -> AnyComponent? {
        switch indexPath.row {
        case IndexPath.headerComponentIndex: return self[safe: indexPath.section]?.header?.component
        case IndexPath.footerComponentIndex: return self[safe: indexPath.section]?.footer?.component
        default: return self[safe: indexPath.section]?.cells[safe: indexPath.row]?.component
        }
    }

    @inlinable
    func viewNode(for indexPath: IndexPath) -> ViewNode? {
        switch indexPath.row {
        case IndexPath.headerComponentIndex: return self[safe: indexPath.section]?.header
        case IndexPath.footerComponentIndex: return self[safe: indexPath.section]?.footer
        default: return nil
        }
    }

    /// Item location in collection by id
    /// - Parameter id: id item
    @inlinable
    func indexPath(for id: AnyHashable) -> IndexPath? {
        return enumerated().compactMap { (index, section) in
            return section.cells.firstIndex(where: { $0.id == id })
                .flatMap { IndexPath(item: $0, section: index) }
        }.first
    }
}

public extension Array {
    subscript (safe index: Int?) -> Element? {
        get {
            guard let index = index else { return nil }
            return index < count && index >= 0 ? self[index] : nil
        }
        set(newValue) {
            guard let index = index, let newValue = newValue else { return }
            self[index] = newValue
        }
    }
}
