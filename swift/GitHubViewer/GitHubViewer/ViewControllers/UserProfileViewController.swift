import UIKit

class UserProfileViewController: UITableViewController {
    enum TableCellType: Int {
        case UserInfo
        case UserProfile
        static let count = 2
    }

    enum RowType: Int {
        case Email
        case BlogURL
        case Location
        case JoinedDate
        static let count = 4
    }

    let defaultCellHeight: CGFloat = 44.0

    // MARK: - tableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TableCellType.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellType = TableCellType(rawValue: section) else {
            fatalError("Accesssing undefined section")
        }
        switch cellType {
        case .UserInfo:
            return 1
        case .UserProfile:
            return RowType.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Accesssing undefined section")
        }
        switch cellType {
        case .UserInfo:
            let cell: UserInfoTableViewCell = tableView.ghv_dequeueReusableCell(for: indexPath)
            return cell
        case .UserProfile:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserProfileCell", forIndexPath: indexPath)
            guard let rowType = RowType(rawValue: indexPath.row) else {
                fatalError("Accesssing undefined section row")
            }
            switch rowType {
            case .Email:
                cell.textLabel?.text = "Email"
            case .BlogURL:
                cell.textLabel?.text = "Blog URL"
            case .Location:
                cell.textLabel?.text = "Location"
            case .JoinedDate:
                cell.textLabel?.text = "Joined at"
            }
            return cell
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Accesssing undefined section")
        }
        switch cellType {
        case .UserInfo:
            return UserInfoTableViewCell.height
        case .UserProfile:
            return defaultCellHeight
        }
    }
}
