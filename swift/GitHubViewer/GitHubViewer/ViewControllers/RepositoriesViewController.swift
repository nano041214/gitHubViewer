import UIKit

class RepositoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    enum RepositoriesTableCellType: Int {
        case UserInfo
        case Repository

        func toString() -> String {
            switch self {
                case .UserInfo:
                    return "UserInfoCell"
                case .Repository:
                    return "RepositoryCell"
            }
        }

        static var count: Int {
            return RepositoriesTableCellType.Repository.rawValue + 1
        }
    }

    // define value workaround
    let repositoriesCount = 5

    @IBOutlet weak var tableView: UITableView!

    // MARK: - tableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return RepositoriesTableCellType.count;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        switch section {
        case RepositoriesTableCellType.UserInfo.rawValue:
            return 1
        default:
            return repositoriesCount
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case RepositoriesTableCellType.UserInfo.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier(RepositoriesTableCellType.UserInfo.toString(), forIndexPath: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(RepositoriesTableCellType.Repository.toString(), forIndexPath: indexPath)
            return cell
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case RepositoriesTableCellType.UserInfo.rawValue:
            return UserInfoTableViewCell.height
        default:
            return RepositoryTableViewCell.height
        }
    }
}
