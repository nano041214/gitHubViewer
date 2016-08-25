import UIKit

class ActivitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - tableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        switch section {
        case 0:
            return 1
        default:
            return 3
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserInfoCell", forIndexPath: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath)
            return cell
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 139.5
        default:
            return 96.5
        }
    }
    
}
