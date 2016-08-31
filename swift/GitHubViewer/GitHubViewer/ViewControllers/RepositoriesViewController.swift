import UIKit

class RepositoriesViewController: UITableViewController {
    enum TableCellType: Int {
        case UserInfo
        case Repository
    }

    let sectionCount = 2

    // define value workaround
    let repositoriesCount = 5

    var userProvider: UserProvider?

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - tableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionCount
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        guard let cellType = TableCellType(rawValue: section) else {
            fatalError("Accesssing undefined section row")
        }
        switch cellType {
        case .UserInfo:
            return 1
        case .Repository:
            return repositoriesCount
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Accesssing undefined section row")
        }
        switch cellType {
        case .UserInfo:
            guard let cell = tableView.dequeueReusableCellWithIdentifier("UserInfoCell", forIndexPath: indexPath) as? UserInfoTableViewCell else {
                fatalError("Failing to create UserInfoCell")
            }
            cell.user = userProvider?.user
            return cell
        case .Repository:
            let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryCell", forIndexPath: indexPath)
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
        case .Repository:
            return RepositoryTableViewCell.height
        }
    }
}
