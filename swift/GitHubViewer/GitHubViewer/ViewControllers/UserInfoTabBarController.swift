import UIKit

class UserInfoTabBarController: UITabBarController, userProvider {
    var user: User!
}

protocol userProvider {
    var user: User! { get }
}
