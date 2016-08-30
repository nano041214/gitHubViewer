import UIKit
import APIKit

class InquiryViewController: UIViewController {
    @IBAction func didEnterUserName(sender: UITextField) {
        guard let userNameString = sender.text else {
            return
        }
        let request = UserRequest(userName: userNameString)
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let response):
                guard let tabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("UserInfoTabBarController") as? UserInfoTabBarController else {
                    fatalError("Could not load UserInfoTabBarController")
                }
                tabBarController.fetchedUser = response
                self.showViewController(tabBarController, sender: self)
            case .Failure(let error):
                print(error)
            }
        }
    }
}
