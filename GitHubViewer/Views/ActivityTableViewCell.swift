import UIKit

class ActivityTableViewCell: UITableViewCell {

    static let height: CGFloat = 97
    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!

    var activity: Activity? {
        didSet {
            guard let activity = activity else {
                return
            }
            activityNameLabel.text = activity.name
            repositoryNameLabel.text = activity.descriptionString
        }
    }

}
