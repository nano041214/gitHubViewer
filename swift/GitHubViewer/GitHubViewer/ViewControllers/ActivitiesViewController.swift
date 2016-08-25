import UIKit

class ActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    enum ActivitiesTableCellType: Int {
        case UserInfo
        case Activity
    }

    let sectionCount = 2

    // define value workaround
    let activitiesCount = 5

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - tableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionCount;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        switch section {
        case ActivitiesTableCellType.UserInfo.rawValue:
            return 1
        default:
            return activitiesCount
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case ActivitiesTableCellType.UserInfo.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserInfoCell", forIndexPath: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath)
            return cell
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case ActivitiesTableCellType.UserInfo.rawValue:
            return UserInfoTableViewCell.height
        default:
            return ActivityTableViewCell.height
        }
    }
    
}
