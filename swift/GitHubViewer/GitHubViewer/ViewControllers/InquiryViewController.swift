import UIKit

class InquiryViewController: UIViewController {

    @IBAction func didEnterUserName(sender: AnyObject) {
        let tabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("UserInfoTabBarController") as! UserInfoTabBarController
        showViewController(tabBarController, sender: self)
    }

}

