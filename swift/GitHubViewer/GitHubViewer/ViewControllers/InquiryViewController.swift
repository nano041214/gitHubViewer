import UIKit
import APIKit

class InquiryViewController: UIViewController {
    @IBAction func didEnterUserName(sender: UITextField) {
        assert(sender.text != nil, "sender.txt never be nil even if the value has no character")
        let userNameString = sender.text!
        let request = UserRequest(userName: userNameString)
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let response):
                guard let tabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("UserInfoTabBarController") as? UserInfoTabBarController else {
                    fatalError("Could not load UserInfoTabBarController")
                }
                tabBarController.user = response
                self.showViewController(tabBarController, sender: self)
            case .Failure(let error):
                print(error)
            }
        }
    }
}
