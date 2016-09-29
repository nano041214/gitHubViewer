import APIKit
import FontAwesome
import UIKit

class RepositoriesViewController: UITableViewController {
    enum TableCellType: Int {
        case UserInfo
        case Repository
        static let sectionCount = 2
    }

    private var repositories: [Repository] = []
    let navigationBarRightButtonFontSize: CGFloat = 24.0
    private var isLoading: Bool = false
    private var isExistingUnLoadedData = false

    var userProvider: UserProvider?
    @IBOutlet weak var rightBarButton: UIBarButtonItem!

    override func viewDidLoad() {
        let attributes: [String: AnyObject] = [NSFontAttributeName: UIFont.fontAwesomeOfSize(navigationBarRightButtonFontSize)]
        rightBarButton.setTitleTextAttributes(attributes, forState: .Normal)
        rightBarButton.title = String.fontAwesomeIconWithName(.Github)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchRepositories()
    }

    @IBAction func didTapRightBarButton(sender: AnyObject) {
        self.userProvider?.showInquiryViewController()
    }

    func fetchRepositories() {
        guard let userNameString = userProvider?.user?.name else {
            return
        }
        let pageCount: Int = repositories.count / RepositoryRequest.perPage
        let nextPageCount: Int = pageCount + 1

        let request = RepositoryRequest(userName: userNameString, pageCount: nextPageCount)
        isLoading = true
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let repositories):
                self.isLoading = false
                if repositories.count == 0 {
                    self.isExistingUnLoadedData = true
                } else {
                    self.repositories.appendContentsOf(repositories)
                    self.tableView.reloadData()
                }
            case .Failure(_):
                return
            }
        }
    }

    // MARK: - tableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TableCellType.sectionCount
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellType = TableCellType(rawValue: section) else {
            fatalError("Accessing undefined section")
        }
        switch cellType {
        case .UserInfo:
            return 1
        case .Repository:
            return repositories.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Accessing undefined section")
        }
        switch cellType {
        case .UserInfo:
            let cell: UserInfoTableViewCell = tableView.ghv_dequeueReusableCell(for: indexPath)
            cell.user = userProvider?.user
            return cell
        case .Repository:
            let cell: RepositoryTableViewCell = tableView.ghv_dequeueReusableCell(for: indexPath)
            cell.repository = repositories[indexPath.row]
            return cell
        }
    }

    // MARK: - UITableViewDelegate

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Accessing undefined section")
        }
        switch cellType {
        case .UserInfo:
            return UserInfoTableViewCell.height
        case .Repository:
            return RepositoryTableViewCell.height
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == TableCellType.Repository.rawValue {
            guard let repositoryDetailViewController = storyboard?.instantiateViewControllerWithIdentifier(String(RepositoryDetailViewController.self)) as? RepositoryDetailViewController else {
                fatalError("Accessing undefined viewController")
            }
            repositoryDetailViewController.repository = repositories[indexPath.row]
            showViewController(repositoryDetailViewController, sender: nil)
        }
    }

    // MARK: - UIScrollViewDelegate

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffsetWidthWindow = self.tableView.contentOffset.y + self.tableView.bounds.height
        let isScrolledToBottom = contentOffsetWidthWindow >= self.tableView.contentSize.height
        if !isScrolledToBottom || isLoading || isExistingUnLoadedData {
            return
        }
        fetchRepositories()
    }
}
