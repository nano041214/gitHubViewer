import UIKit
import APIKit

class RepositoriesViewController: UITableViewController {
    enum TableCellType: Int {
        case UserInfo
        case Repository
        static let sectionCount = 2
    }

    var repositories: [Repository] = []

    var userProvider: UserProvider?

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        guard let userNameString = userProvider?.user?.name else {
            return
        }
        let request = RepositoryRequest(userName: userNameString)
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let repositories):
                self.repositories = repositories
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
        guard let repositoryDetailViewController = storyboard?.instantiateViewControllerWithIdentifier("RepositoryDetailViewController") as? RepositoryDetailViewController else {
            fatalError("Accessing undefined viewController")
        }
        repositoryDetailViewController.repository = repositories[indexPath.row]
        showViewController(repositoryDetailViewController, sender: nil)
    }
}
