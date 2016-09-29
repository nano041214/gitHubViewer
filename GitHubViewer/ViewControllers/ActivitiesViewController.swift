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

    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        let attributes: [String: AnyObject] = [NSFontAttributeName: UIFont.fontAwesomeOfSize(navigationBarRightButtonFontSize)]
        rightBarButton.setTitleTextAttributes(attributes, forState: .Normal)
        rightBarButton.title = String.fontAwesomeIconWithName(.Github)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        guard let userNameString = userProvider?.user?.name else {
            return
        }
        isLoading = true
        let request = ActivityRequest(userName: userNameString)
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let activities):
                self.activities = activities
                self.tableView.reloadData()
                self.isLoading = false
            case .Failure(let error):
                print(error)
                self.userProvider?.showInquiryViewController()
            }
        }
    }

    @IBAction func didTapRightBarButton(sender: AnyObject) {
        self.userProvider?.showInquiryViewController()
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
        let eachToBottom = contentOffsetWidthWindow >= self.tableView.contentSize.height
        if !eachToBottom || isLoading {
            return
        }
        guard let userNameString = userProvider?.user?.name else {
            return
        }
        let pageCount: Int = activities.count / 5
        let nextPageCount: Int = pageCount + 1
        let request = ActivityRequest(userName: userNameString, pageCount: nextPageCount)
        isLoading = true
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let activities):
                self.activities.appendContentsOf(activities)
                self.tableView.reloadData()
                self.isLoading = false
            case .Failure(_):
                return
            }
        }
    }
}
