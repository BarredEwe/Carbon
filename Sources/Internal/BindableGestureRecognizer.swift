import UIKit

final class BindableGestureRecognizer: UITapGestureRecognizer {
    private var action: (UIView) -> Void

    init(action: @escaping (UIView) -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        delegate = self
        addTarget(self, action: #selector(controlAction(_:)))
    }

    @objc private func controlAction(_ gesture: BindableGestureRecognizer) {
        guard let view = gesture.view else { return }
        action(view)
    }
}

extension BindableGestureRecognizer: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        !(touch.view?.isUserInteractionEnabled == true && touch.view is UIControl)
    }
}
