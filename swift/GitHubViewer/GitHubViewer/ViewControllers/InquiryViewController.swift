import UIKit

class InquiryViewController: UIViewController {
    @IBAction func didEnterUserName(sender: UITextField) {
        guard let tabBarController = storyboard?.instantiateViewControllerWithIdentifier("UserInfoTabBarController") as? UserInfoTabBarController else {
            fatalError("Could not load UserInfoTabBarController")
        }
        showViewController(tabBarController, sender: self)
    }
}
