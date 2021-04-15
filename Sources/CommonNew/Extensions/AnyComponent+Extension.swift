extension AnyComponent: Equatable {
    public static func == (lhs: AnyComponent, rhs: AnyComponent) -> Bool {
        lhs.shouldContentUpdate(with: rhs)
    }
}

extension IdentifiableComponent {
    var anyComponent: AnyComponent {
        AnyComponent(self)
    }
}
