import UIKit
import APIKit

class RepositoriesViewController: UITableViewController {
    enum TableCellType: Int {
        case UserInfo
        case Repository
    }

    let sectionCount = 2

    // define value workaround
    let repositoriesCount = 5

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
                print(repositories)
            case .Failure(let error):
                print(error)
                assertionFailure("Should display an error message")
            }
        }
        tableView.reloadData()
    }

    // MARK: - tableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionCount
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellType = TableCellType(rawValue: section) else {
            fatalError("Accessing undefined section")
        }
        switch cellType {
        case .UserInfo:
            return 1
        case .Repository:
            return repositoriesCount
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
            let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryCell", forIndexPath: indexPath)
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
}
