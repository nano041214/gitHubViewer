import UIKit

class RepositoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    enum TableCellType: Int {
        case UserInfo
        case Repository
    }

    let sectionCount = 2

    // define value workaround
    let repositoriesCount = 5

    @IBOutlet weak var tableView: UITableView!

    // MARK: - tableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionCount
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
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

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Accesssing undefined section row")
        }
        switch cellType {
        case .UserInfo:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserInfoCell", forIndexPath: indexPath)
            return cell
        case .Repository:
            let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryCell", forIndexPath: indexPath)
            return cell
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
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
