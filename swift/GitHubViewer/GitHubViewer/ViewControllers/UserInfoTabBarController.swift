import UIKit

class UserInfoTabBarController: UITabBarController, userProvider {
    var user: User = User(name: "cookpad",
                          iconURL: NSURL(string: "https://avatars.githubusercontent.com/u/119195?v=3")!,
                          followersCount: 0,
                          followingCount: 0,
                          blogURL: nil,
                          mailAddress: nil,
                          location: nil,
                          joinedDate: NSDate())
}

protocol userProvider {
    var user: User { get }
}
