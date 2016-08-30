import UIKit

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var followedLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var starredLabel: UILabel!

    static let height: CGFloat = 140

    var userProvider: UserProvider! {
        get {
            return self.userProvider
        }

        set {
            self.userNameLabel.text = userProvider.user.name
        }
    }



}
