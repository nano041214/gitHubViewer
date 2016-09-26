import UIKit

class UserProfileViewController: UITableViewController {
    enum TableCellType: Int {
        case UserInfo
        case UserProfile
        static let count = 2
    }

    enum ProfileRow: Int {
        case Email
        case BlogURL
        case Location
        case JoinedDate
        static let count = 4

        var title: String {
            switch self {
            case .Email:
                return "Email"
            case .BlogURL:
                return "Blog URL"
            case .Location:
                return "Location"
            case .JoinedDate:
                return "Joined at"
            }
        }
    }

    let defaultCellHeight: CGFloat = 44.0
    var user: User?

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
            return ProfileRow.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Accesssing undefined section")
        }
        switch cellType {
        case .UserInfo:
            let cell: UserInfoTableViewCell = tableView.ghv_dequeueReusableCell(for: indexPath)
            cell.user = user
            return cell
        case .UserProfile:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserProfileCell", forIndexPath: indexPath)
            guard let rowType = ProfileRow(rawValue: indexPath.row) else {
                fatalError("Accesssing undefined section row")
            }
            cell.textLabel?.text = rowType.title
            switch rowType {
            case .Email:
                 cell.detailTextLabel?.text = user?.mailAddress ?? "Private"
            case .BlogURL:
                cell.detailTextLabel?.text = user?.blogURL?.absoluteString ?? "Private"
            case .Location:
                cell.detailTextLabel?.text = user?.location ?? "Private"
            case .JoinedDate:
                if let joinedDate = user?.joinedDate {
                    cell.detailTextLabel?.text = String(joinedDate)
                }
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
