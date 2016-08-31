import UIKit

class UserProfileViewController: UITableViewController {
    enum TableCellType: Int {
        case UserInfo
        case UserProfile
    }

    enum RowType: Int {
        case Email
        case BlogURL
        case Location
        case JoinedDate
        static let count = 4
    }

    let sectionCount = 2

    // MARK: - tableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionCount;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        guard let cellType = TableCellType(rawValue: section) else {
            fatalError("Accesssing undefined section row")
        }
        switch cellType {
        case .UserInfo:
            return 1
        case .UserProfile:
            return RowType.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Accesssing undefined section row")
        }
        switch cellType {
        case .UserInfo:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserInfoCell", forIndexPath: indexPath)
            return cell
        case .UserProfile:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserProfileCell", forIndexPath: indexPath)
            return cell
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Accesssing undefined section row")
        }
        switch cellType {
        case .UserInfo:
            return UserInfoTableViewCell.height
        case .UserProfile:
            return ActivityTableViewCell.height
        }
    }
}
