import APIKit
import UIKit
import FontAwesome

class ActivitiesViewController: UITableViewController {
    enum TableCellType: Int {
        case UserInfo
        case Activity
        static let sectionCount = 2
    }

    var userProvider: UserProvider?
    let navigationBarRightButtonFontSize: CGFloat = 24.0
    private var activities: [Activity] = []

    private var isLoading: Bool = false
    private var isExistingUnLoadedData = false

    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        let attributes: [String: AnyObject] = [NSFontAttributeName: UIFont.fontAwesomeOfSize(navigationBarRightButtonFontSize)]
        rightBarButton.setTitleTextAttributes(attributes, forState: .Normal)
        rightBarButton.title = String.fontAwesomeIconWithName(.Github)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchActivities()
    }

    @IBAction func didTapRightBarButton(sender: AnyObject) {
        self.userProvider?.showInquiryViewController()
    }

    func fetchActivities() {
        guard let userNameString = userProvider?.user?.name else {
            return
        }
        let pageCount: Int = activities.count / ActivityRequest.perPage
        let nextPageCount: Int = pageCount + 1

        let request = ActivityRequest(userName: userNameString, pageCount: nextPageCount)
        isLoading = true
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let activities):
                self.isLoading = false
                if activities.count == 0 {
                    self.isExistingUnLoadedData = true
                } else {
                    self.activities.appendContentsOf(activities)
                    self.tableView.reloadData()
                }
            case .Failure(_):
                return
            }
        }
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
            fatalError("Accesssing undefined section")
        }
        switch cellType {
        case .UserInfo:
            return 1
        case .Activity:
            return activities.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Accesssing undefined section row")
        }
        switch cellType {
        case .UserInfo:
            let cell: UserInfoTableViewCell = tableView.ghv_dequeueReusableCell(for: indexPath)
            cell.user = userProvider?.user
            return cell
        case .Activity:
            let cell: ActivityTableViewCell = tableView.ghv_dequeueReusableCell(for: indexPath)
            cell.activity = activities[indexPath.row]
            return cell
        }
    }

    // MARK: - UITableViewDelegate

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard let cellType = TableCellType(rawValue: indexPath.section) else {
            fatalError("Accesssing undefined section")
        }
        switch cellType {
        case .UserInfo:
            return UserInfoTableViewCell.height
        case .Activity:
            return ActivityTableViewCell.height
        }
    }

    // MARK: - UIScrollViewDelegate

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffsetWidthWindow = self.tableView.contentOffset.y + self.tableView.bounds.height
        let isScrolledToBottom = contentOffsetWidthWindow >= self.tableView.contentSize.height
        if !isScrolledToBottom || isLoading || isExistingUnLoadedData {
            return
        }
        fetchActivities()
    }
}
