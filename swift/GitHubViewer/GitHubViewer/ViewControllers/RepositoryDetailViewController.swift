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

    let defaultCellHeight: CGFloat = 44.0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib.init(nibName: String(GitHubLinkView.self), bundle: nil), forHeaderFooterViewReuseIdentifier: String(GitHubLinkView.self))
    }

    // MARK: - tableViewDataSource

    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let sectionType = TableCellType(rawValue: section) else {
            fatalError("Accessing undefined section")
        }
        switch sectionType {
        case .Title:
            return nil
        case .Detail:
            let linkView: GitHubLinkView = tableView.ghv_dequeueReusableHeaderFooterView()
            return linkView
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TableCellType.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
            return defaultCellHeight
        }
    }

    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let cellType = TableCellType(rawValue: section) else {
            fatalError("Accesssing undefined section")
        }
        switch cellType {
        case .Title:
            return 0
        case .Detail:
            return GitHubLinkView.height
        }
    }
}
