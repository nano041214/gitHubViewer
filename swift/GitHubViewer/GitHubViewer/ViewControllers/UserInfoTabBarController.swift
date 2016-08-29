import UIKit

class UserInfoTabBarController: UITabBarController {
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        print(user)
    }
}
