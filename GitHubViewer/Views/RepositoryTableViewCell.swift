import UIKit

class RepositoryTableViewCell: UITableViewCell {

    static let height: CGFloat = 97
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starredCountLabel: UILabel!

    var repository: Repository? {
        didSet {
            guard let repository = repository else {
                return
            }
            nameLabel.text = repository.name
            starredCountLabel.text = String(repository.starredCount)
        }
    }
}
