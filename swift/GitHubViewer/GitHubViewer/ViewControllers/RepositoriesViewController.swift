import UIKit

class RepositoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    enum RepositoriesTableCell: Int {
        case UserInfoCell
        case RepositoryCell

        func toString() -> String {
            switch self {
                case .UserInfoCell:
                    return "UserInfoCell"
                case .RepositoryCell:
                    return "RepositoryCell"            }
        }

        func height() -> CGFloat {
            switch self {
            case .UserInfoCell:
                return 139.5
            case .RepositoryCell:
                return 96.5
            }
        }

        static var count: Int { return RepositoriesTableCell.RepositoryCell.hashValue + 1}
    }

    // define value workaround
    let repositoriesCount = 5

    @IBOutlet weak var tableView: UITableView!

    // MARK: - tableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return RepositoriesTableCell.count;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        switch section {
        case 0:
            return 1
        default:
            return repositoriesCount
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserInfoCell", forIndexPath: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryCell", forIndexPath: indexPath)
            return cell
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case RepositoriesTableCell.UserInfoCell.rawValue:
            return RepositoriesTableCell.UserInfoCell.height()
        default:
            return RepositoriesTableCell.RepositoryCell.height()
        }
    }
}
