import UIKit

class RepositoryDetailViewController: UITableViewController {
    enum TableCellType: Int {
        case Title
        case Detail
        static let count = 2
    }

    // define value workaround
    let activitiesCount = 5

    // MARK: - tableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TableCellType.count;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        guard let cellType = TableCellType(rawValue: section) else {
            fatalError("Accesssing undefined section")
        }
        switch cellType {
        case .Title:
            return 1
        case .Detail:
            return activitiesCount
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Accesssing undefined section row")
        }
        switch cellType {
        case .Title:
            let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryTitleCell", forIndexPath: indexPath)
            return cell
        case .Detail:
            let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryDetailCell", forIndexPath: indexPath)
            return cell
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Accesssing undefined section")
        }
        switch cellType {
        case .Title:
            return 185.0
        case .Detail:
            return 44.0
        }
    }
}
