import UIKit

class ActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    enum TableCellType: Int {
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
        guard let cellType = TableCellType(rawValue: section) else {
            fatalError("Acesssing undefined section row")
        }
        switch cellType {
        case .UserInfo:
            return 1
        default:
            return activitiesCount
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Acesssing undefined section row")
        }
        switch cellType {
        case .UserInfo:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserInfoCell", forIndexPath: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath)
            return cell
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Acesssing undefined section row")
        }
        switch cellType {
        case .UserInfo:
            return UserInfoTableViewCell.height
        default:
            return ActivityTableViewCell.height
        }
    }
    
}
