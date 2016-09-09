import UIKit

class RepositoryTableViewCell: UITableViewCell {

    static let height: CGFloat = 97
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starredCountLabel: UILabel!

    var repository: Repository? {
        didSet {
            guard let fetchedRepository = repository else {
                return
            }
            nameLabel.text = fetchedRepository.name
            starredCountLabel.text = String(fetchedRepository.starredCount)
        }
    }
}
