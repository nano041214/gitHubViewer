import UIKit
import APIKit

class InquiryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didEnterUserName(sender: UITextField) {
        guard let userNameString: String = sender.text else {
            fatalError("it's not string")
        }
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
