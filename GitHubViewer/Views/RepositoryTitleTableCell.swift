import UIKit

class RepositoryTitleTableCell: UITableViewCell {
    static let height: CGFloat = 185.0

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var repositoryTitleLabel: UILabel!

    var repository: Repository? {
        didSet {
            guard let fetchedRepository = repository else {
                return
            }
            dateLabel.text = String(fetchedRepository.createdDate)
            repositoryTitleLabel.text = "\(fetchedRepository.userName)\n\(fetchedRepository.name)"
            descriptionLabel.text = fetchedRepository.descriptionString
        }
    }
}
