import UIKit

extension UITableView {
    func ghv_dequeueReusableCell<TableViewCellType: UITableViewCell>(identifier identifier: String = String(TableViewCellType), for indexPath: NSIndexPath) -> TableViewCellType {
        guard let cell = dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? TableViewCellType else {
            fatalError("Failing to create \(TableViewCellType.self)")
        }
        return cell
    }

    func ghv_dequeueReusableHeaderFooterView<TableViewHeaderFooterView: UITableViewHeaderFooterView>() -> TableViewHeaderFooterView {
        guard let headerFooterView = dequeueReusableHeaderFooterViewWithIdentifier(String(TableViewHeaderFooterView.self)) as? TableViewHeaderFooterView else {
            fatalError("Failing to create \(TableViewHeaderFooterView.self)")
        }
        return headerFooterView
    }
}
