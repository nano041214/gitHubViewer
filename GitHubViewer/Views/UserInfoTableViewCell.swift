import Kingfisher
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
            let placeholderImage = UIImage(named: "octcat")
            if let user = user {
                iconImageView.kf_setImageWithURL(user.iconURL,
                                                 placeholderImage: placeholderImage,
                                                 optionsInfo: nil,
                                                 progressBlock: nil,
                                                 completionHandler: nil)
                userNameLabel.text = user.name
                followedLabel.text = String(user.followersCount)
                followingLabel.text = String(user.followingCount)
            } else {
                iconImageView.image = placeholderImage
                userNameLabel.text = "No user was selected"
                followedLabel.text = "?"
                followingLabel.text = "?"
            }
        }
    }
}
