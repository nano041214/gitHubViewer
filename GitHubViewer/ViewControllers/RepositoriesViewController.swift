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
    private var isLoading = false
    private var isExistingUnLoadedData = false
    private var currentPageCount = 0

    var userProvider: UserProvider?
    @IBOutlet weak var rightBarButton: UIBarButtonItem!

    override func viewDidLoad() {
        let attributes: [String: AnyObject] = [NSFontAttributeName: UIFont.fontAwesomeOfSize(navigationBarRightButtonFontSize)]
        rightBarButton.setTitleTextAttributes(attributes, forState: .Normal)
        rightBarButton.title = String.fontAwesomeIconWithName(.Github)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func didTapRightBarButton(sender: AnyObject) {
        self.userProvider?.showInquiryViewController()
    }

    func setOtherUser() {
        resetPropertiesForNextUser()
        fetchRepositories()
    }

    func fetchRepositories() {
        guard let userNameString = userProvider?.user?.name else {
            return
        }
        let nextPageCount = currentPageCount + 1
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
                    self.currentPageCount += 1
                    self.tableView.reloadData()
                }
            case .Failure(_):
                // TODO: error handling
                return
            }
        }
    }

    func resetPropertiesForNextUser() {
        isLoading = false
        isExistingUnLoadedData = false
        currentPageCount = 0
        repositories = []
        let tableTopIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        tableView.scrollToRowAtIndexPath(tableTopIndexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        tableView.reloadData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let userProfileViewController = segue.destinationViewController as? UserProfileViewController {
            userProfileViewController.user = userProvider?.user
        }
    }

    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if userProvider?.user == nil {
            return false
        } else {
            return true
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

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let isScrolledToBottom = (indexPath.section == TableCellType.sectionCount - 1 && indexPath.row == repositories.count - 1)
        if !isScrolledToBottom || isLoading || isExistingUnLoadedData {
            return
        }
        fetchRepositories()
    }
}
