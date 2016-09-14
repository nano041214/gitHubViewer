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
        case Followers
        case Commits
        case Issues
        case Forks

        static let count = 7

        func toString () -> String {
            switch self {
            case .Language:
                return "Language"
            case .Starred:
                return "Starred"
            case .Watchers:
                return "Watchers"
            case .Followers:
                return "Followers"
            case .Commits:
                return "Commits"
            case .Issues:
                return "Issues"
            case .Forks:
                return "Forks"
            }
        }
    }

    let defaultCellHeight: CGFloat = 44.0
    var repository: Repository?

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
            let cell: RepositoryTitleTableCell = tableView.ghv_dequeueReusableCell(for: indexPath)
            cell.repository = repository
            return cell
        case .Detail:
            let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryDetailCell", forIndexPath: indexPath)
            guard let titleType = ProfileTitle(rawValue: indexPath.row) else {
                fatalError("Accesssing undefined section row")
            }

            cell.textLabel?.text = titleType.toString()
            switch titleType {
            case .Forks:
                cell.detailTextLabel?.text = String(repository?.forksCount)
            case .Commits:
                cell.detailTextLabel?.text = String(repository?.commitsCount)
            case .Followers:
                cell.detailTextLabel?.text = String(repository?.followersCount)
            case .Issues:
                cell.detailTextLabel?.text = String(repository?.issuesCount)
            case .Language:
                cell.detailTextLabel?.text = repository?.language
            case .Starred:
                cell.detailTextLabel?.text = String(repository?.starredCount)
            case .Watchers:
                cell.detailTextLabel?.text = String(repository?.watchersCount)
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
