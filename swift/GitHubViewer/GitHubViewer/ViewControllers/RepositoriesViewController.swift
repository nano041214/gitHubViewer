import UIKit

class RepositoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    enum RepositoriesTableCellTyle: Int {
        case UserInfoType
        case RepositoryType

        func toString() -> String {
            switch self {
                case .UserInfoType:
                    return "UserInfoCell"
                case .RepositoryType:
                    return "RepositoryCell"
            }
        }

        static var count: Int { return RepositoriesTableCellTyle.RepositoryType.rawValue + 1 }
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
        case RepositoriesTableCellTyle.UserInfoType.rawValue:
            return 1
        default:
            return repositoriesCount
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case RepositoriesTableCellTyle.UserInfoType.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier(RepositoriesTableCellTyle.UserInfoType.toString(), forIndexPath: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(RepositoriesTableCellTyle.RepositoryType.toString(), forIndexPath: indexPath)
            return cell
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case RepositoriesTableCellTyle.UserInfoType.rawValue:
            return UserInfoTableViewCell.height
        default:
            return RepositoryTableViewCell.height
        }
    }
}
