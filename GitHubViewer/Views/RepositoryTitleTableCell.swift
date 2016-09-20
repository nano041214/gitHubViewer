import UIKit

class RepositoryTitleTableCell: UITableViewCell {
    static let height: CGFloat = 185.0

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var repositoryTitleLabel: UILabel!

    var repository: Repository? {
        didSet {
            if let repository = repository {
                dateLabel.text = repository.formattedCreatedAndUpdatedDateString
                repositoryTitleLabel.text = repository.formattedRepositoryName
                descriptionLabel.text = repository.descriptionString
            } else {
                dateLabel.text = ""
                repositoryTitleLabel.text = ""
                descriptionLabel.text = ""
            }
        }
    }
}
