import Carbon

public class ActionDelegate<View: ActionableComponent>: Equatable {
    var view: View
    private var actions: [View.Content.Action: ActionCompletion<View>] = [:]

    public init(view: View) {
        self.view = view
    }

    func append(completion: @escaping ActionCompletion<View>, for action: View.Content.Action) {
        actions[action] = completion
    }

    public func call(action: View.Content.Action, sender: View.Content, itemInfo: View.Content.ItemInfo) {
        updateView(action: action, sender: sender, info: itemInfo)
        guard let completion = actions[action] else { return }
        completion(view, itemInfo)
    }

    public func call(action: View.Content.Action, sender: View.Content) where View.Content.ItemInfo == Void {
        call(action: action, sender: sender, itemInfo: ())
    }

    // MARK: Private Methods
    private func updateView(action: View.Content.Action, sender: View.Content, info: View.Content.ItemInfo) {
        guard let newView = view.needChange(for: action, info: info),
              let target = (sender as? UIView)?.superview(as: UITableView.self),
              let adapter = target.dataSource as? Adapter else { return }

        if let indexPath = adapter.data.indexPath(for: view.id), view.shouldContentUpdate(with: newView) {
            view = newView
            var data = adapter.data
            data.update(component: view, for: indexPath)
            adapter.renderer?.render(data)
        } else {
            view = newView
            adapter.renderer?.render(adapter.data)
        }
    }
}

public extension ActionDelegate {
    static func == (lhs: ActionDelegate<View>, rhs: ActionDelegate<View>) -> Bool {
        lhs.view == rhs.view && Set(lhs.actions.keys) == Set(rhs.actions.keys)
    }
}
