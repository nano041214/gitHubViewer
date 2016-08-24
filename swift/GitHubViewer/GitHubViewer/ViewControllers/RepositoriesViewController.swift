import UIKit

class RepositoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    enum RepositoriesTableCellTyle: Int {
        case UserInfoCell
        case RepositoryCell

        func toString() -> String {
            switch self {
                case .UserInfoCell:
                    return "UserInfoCell"
                case .RepositoryCell:
                    return "RepositoryCell"
            }
        }

        static var count: Int { return RepositoriesTableCellTyle.RepositoryCell.hashValue + 1 }
    }

    // define value workaround
    let repositoriesCount = 5

    @IBOutlet weak var tableView: UITableView!

    // MARK: - tableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return RepositoriesTableCellTyle.count;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        switch section {
        case RepositoriesTableCellTyle.UserInfoCell.rawValue:
            return 1
        default:
            return repositoriesCount
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case RepositoriesTableCellTyle.UserInfoCell.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier(RepositoriesTableCellTyle.UserInfoCell.toString(), forIndexPath: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(RepositoriesTableCellTyle.RepositoryCell.toString(), forIndexPath: indexPath)
            return cell
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case RepositoriesTableCellTyle.UserInfoCell.rawValue:
            return 139.5
        default:
            return 96.5
        }
    }
}
