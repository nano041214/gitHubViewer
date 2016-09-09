import UIKit

class RepositoryTableViewCell: UITableViewCell {

    static let height: CGFloat = 97

    var repository: Repository? {
        didSet {
            guard let fetchedRepository = repository else {
                return
            }
            textLabel?.text = fetchedRepository.name
        }
    }
}
