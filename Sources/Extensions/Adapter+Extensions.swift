import UIKit

public extension Adapter {

    @inlinable
    public func component<Type: Hashable>(for id: Type) -> AnyComponent? {
        return data.component(for: id)
    }

    @inlinable
    public func indexPath(for cell: UITableViewComponentCell) -> IndexPath? {
        guard let tableView = cell.superview as? UITableView else { return nil }
        return tableView.indexPath(for: cell)
    }

    @inlinable
    public func indexPath(for cell: UICollectionViewComponentCell) -> IndexPath? {
        guard let collectionView = cell.superview as? UICollectionView else { return nil }
        return collectionView.indexPath(for: cell)
    }

    @inlinable
    public func indexPath(for headerFooterView: UITableViewComponentHeaderFooterView) -> IndexPath? {
        guard let tableView = headerFooterView.superview as? UITableView else { return nil }
        return data.enumerated().lazy
            .filter { $0.element.header != nil || $0.element.footer != nil }
            .compactMap { $0.offset }
            .first(where: { tableView.headerView(forSection: $0) == headerFooterView || tableView.footerView(forSection: $0) == headerFooterView })
            .flatMap { (tableView.headerView(forSection: $0) == headerFooterView ? IndexPath.headerComponentIndex : IndexPath.footerComponentIndex, $0) }
            .flatMap { IndexPath(item: $0.0, section: $0.1) }
    }

    @inlinable
    public func indexPath(for id: AnyHashable) -> IndexPath? {
        return data.indexPath(for: id)
    }

    @inlinable
    public func cellNode(for indexPath: IndexPath) -> CellNode? {
        return cellNodes(in: indexPath.section)?[safe: indexPath.row]
    }

    @inlinable
    public func viewNode(for indexPath: IndexPath) -> ViewNode? {
        switch indexPath.row {
        case IndexPath.headerComponentIndex: return data[safe: indexPath.section]?.header
        case IndexPath.footerComponentIndex: return data[safe: indexPath.section]?.footer
        default: return nil
        }
    }

    @inlinable
    public func cellNodes(in section: Int) -> [CellNode]? {
        return data[safe: section]?.cells
    }

    /// Search for a component by indexPath
    /// - Parameter indexPath: indexPath component
    @inlinable
    public func component(for indexPath: IndexPath) -> AnyComponent? {
        return data.component(for: indexPath)
    }
}

/// Methods of changing an array with data (data)
public extension Adapter {

    /// Updating the IdentifiableComponent object according to the passed indexPath
    /// - Parameters:
    ///   - component: IdentifiableComponent object
    ///   - indexPath: IndexPath, according to which component should be updated
    @inlinable
    public func update<Component: IdentifiableComponent>(component: Component?, for indexPath: IndexPath?) {
        data.update(component: component, for: indexPath)
    }

    /// Updating the CellNode object according to the passed indexPath
    /// - Parameters:
    ///   - node: CellNode object
    ///   - indexPath: IndexPath by which node should be updated
    @inlinable
    public func update(node: CellNode?, for indexPath: IndexPath?) {
        data.update(node: node, for: indexPath)
    }

    /// Updating the ViewNode of an object according to the passed indexPath
    /// - Parameters:
    ///   - node: ViewNode object
    ///   - indexPath: IndexPath by which node should be updated
    @inlinable
    public func update(node: ViewNode?, for indexPath: IndexPath?) {
        data.update(node: node, for: indexPath)
    }

    /// Updating AnyComponent object according to the passed indexPath
    /// - Parameters:
    ///   - node: AnyComponent object
    ///   - indexPath: IndexPath by which node should be updated
    @inlinable
    public func update(anyComponent: AnyComponent?, for indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        switch indexPath.row {
        case IndexPath.headerComponentIndex, IndexPath.footerComponentIndex:
            let node = anyComponent?.as(ComponentUpdater.self)?.componentViewNode
            if let actions = viewNode(for: indexPath)?.actions { node?.actions = actions }
            update(node: node, for: indexPath)
        default:
            let node = anyComponent?.as(ComponentUpdater.self)?.componentCellNode
            if let actions = cellNode(for: indexPath)?.actions { node?.actions = actions }
            update(node: node, for: indexPath)
        }
    }

    /// Removing a CellNode object by the passed indexPath
    /// - Parameter indexPath:IndexPath by which node should be deleted
    @inlinable
    public func removeNode(for indexPath: IndexPath?) {
        data.removeNode(for: indexPath)
    }

    /// Insert a CellNode object according to the passed indexPath
    /// - Parameters:
    ///   - node: CellNode object
    ///   - indexPath: IndexPath by which node should be inserted
    @inlinable
    public func insert(node: CellNode, for indexPath: IndexPath?) {
        data.insert(node: node, for: indexPath)
    }
}
