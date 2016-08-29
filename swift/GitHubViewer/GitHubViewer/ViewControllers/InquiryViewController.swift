import UIKit
import APIKit

class InquiryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = UserRequest(userName: "nano041214")
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let response):
                print(response)
            case .Failure(let error):
                print(error)

            }
        }
    }

    @IBAction func didEnterUserName(sender: UITextField) {
        guard let tabBarController = storyboard?.instantiateViewControllerWithIdentifier("UserInfoTabBarController") as? UserInfoTabBarController else {
            fatalError("Could not load UserInfoTabBarController")
        }
        showViewController(tabBarController, sender: self)
    }
}
