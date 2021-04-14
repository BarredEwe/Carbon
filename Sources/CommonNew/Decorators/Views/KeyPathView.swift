import Carbon

public struct KeyPathView<View: IdentifiableComponent, T: Equatable>: DecorationView {
    public let id: View.ID
    public let view: View
    public let keyPath: WritableKeyPath<View.Content, T>
    public let value: T

    public init(id: View.ID, view: View, keyPath: WritableKeyPath<View.Content, T>, value: T) {
        self.id = id
        self.view = view
        self.keyPath = keyPath
        self.value = value
    }

    public func render(in content: View.Content) {
        var content = content
        content[keyPath: keyPath] = value
        view.render(in: content)
    }
}
