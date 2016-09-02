import UIKit

class RepositoryDetailViewController: UITableViewController {
    enum TableCellType: Int {
        case Title
        case Detail
        static let count = 2
    }

    enum ProfileTitle: Int {
        case Language
        case Starred
        case Watchers
        case Contributers
        case Commits
        case Issues
        case Branches
        static let count = 7
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib.init(nibName: String(GitHubLinkView.self), bundle: nil), forHeaderFooterViewReuseIdentifier: String(GitHubLinkView.self))
    }

    // MARK: - tableViewDataSource

    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let linkView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(String(GitHubLinkView.self)) as? GitHubLinkView else {
            print(String(GitHubLinkView.self))
            return nil
        }
        return linkView
    }

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
            return ProfileTitle.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Accesssing undefined section")
        }
        switch cellType {
        case .Title:
            let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryTitleCell", forIndexPath: indexPath)
            return cell
        case .Detail:
            let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryDetailCell", forIndexPath: indexPath)
            guard let titleType = ProfileTitle(rawValue: indexPath.row) else {
                fatalError("Accesssing undefined section row")
            }
            switch titleType {
            case .Branches:
                cell.textLabel?.text = "Branches"
            case .Commits:
                cell.textLabel?.text = "Commits"
            case .Contributers:
                cell.textLabel?.text = "Contributers"
            case .Issues:
                cell.textLabel?.text = "Issues"
            case .Language:
                cell.textLabel?.text = "Language"
            case .Starred:
                cell.textLabel?.text = "Starred"
            case .Watchers:
                cell.textLabel?.text = "Watchers"
            }
            return cell
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Accesssing undefined section")
        }
        switch cellType {
        case .Title:
            return RepositoryTitleTableCell.height
        case .Detail:
            return 44.0
        }
    }
}
