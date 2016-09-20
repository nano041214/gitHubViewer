import UIKit

extension UIViewController {
    func ghv_instantiateViewController<ViewControllerType: UIViewController>() -> ViewControllerType {
        let className = String(ViewControllerType)
        guard let viewController = storyboard?.instantiateViewControllerWithIdentifier(className) as? ViewControllerType else {
            fatalError("Could not load \(className)")
        }
        return viewController
    }
}
