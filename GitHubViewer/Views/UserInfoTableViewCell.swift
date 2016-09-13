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
            guard let fetchedUser = user else {
                return
            }
            self.userNameLabel.text = fetchedUser.name
            self.followedLabel.text = String(fetchedUser.followersCount)
            self.followingLabel.text = String(fetchedUser.followingCount)
        }
    }
}
