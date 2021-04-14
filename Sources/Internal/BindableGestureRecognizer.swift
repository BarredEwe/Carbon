import UIKit

final class BindableGestureRecognizer: UITapGestureRecognizer {
    private var action: () -> Void

    init(action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        delegate = self
        addTarget(self, action: #selector(controlAction))
    }

    @objc private func controlAction() {
        action()
    }
}

extension BindableGestureRecognizer: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        !(touch.view?.isUserInteractionEnabled == true && touch.view is UIControl)
    }
}
