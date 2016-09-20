import UIKit

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var followedLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var starredLabel: UILabel!

    static let height: CGFloat = 140

    var user: User? {
        didSet {
            if let user = user {
                self.userNameLabel.text = user.name
                self.followedLabel.text = String(user.followersCount)
                self.followingLabel.text = String(user.followingCount)
            } else {
                self.userNameLabel.text = "No user was selected"
                self.followedLabel.text = "?"
                self.followingLabel.text = "?"
            }
        }
    }
}
