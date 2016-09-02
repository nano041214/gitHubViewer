import UIKit

extension UITableView {
    func ghv_dequeueReusableCell<TableViewCellType: UITableViewCell>(identifier identifier: String = String(TableViewCellType), for indexPath: NSIndexPath) -> TableViewCellType {
        guard let cell = dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? TableViewCellType else {
            fatalError("Failing to create \(TableViewCellType.self)")
        }
        return cell
    }
}
