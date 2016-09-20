import UIKit

class ActivityTableViewCell: UITableViewCell {

    static let height: CGFloat = 97
    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!

    var activity: Activity? {
        didSet {
            if let activity = activity {
                activityNameLabel.text = activity.name
                repositoryNameLabel.text = activity.descriptionString
            } else {
                activityNameLabel.text = "no activity name fetched"
                repositoryNameLabel.text = "no repository name fetched"
            }
        }
    }

}
