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
        let request = ActivityRequest(userName: userNameString)
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let activities):
                self.activities = activities
                self.tableView.reloadData()
            case .Failure(_):
                let inquiryViewController: InquiryViewController = self.ghv_instantiateViewController()
                guard let userInfoTabBarController: UserInfoTabBarController = self.tabBarController as? UserInfoTabBarController else {
                    fatalError("Could not load \(UserInfoTabBarController.self)")
                }
                inquiryViewController.delegate = userInfoTabBarController
                self.presentViewController(inquiryViewController, animated: true, completion: nil)
            }
        }
    }

    @IBAction func didTapRightBarButton(sender: AnyObject) {
        let inquiryViewController: InquiryViewController = ghv_instantiateViewController()
        guard let userInfoTabBarController = tabBarController as? UserInfoTabBarController else {
            fatalError("Could not load \(UserInfoTabBarController.self)")
        }
        inquiryViewController.delegate = userInfoTabBarController
        presentViewController(inquiryViewController, animated: true, completion: nil)
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
}
