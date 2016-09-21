import UIKit

class GitHubLinkView: UITableViewHeaderFooterView {
    static let height: CGFloat = 65.0
    weak var delegate: GitHubLinkViewDelegate?

    @IBAction func didTapLinkViewButton(sender: AnyObject) {
        delegate?.didTapLinkViewButton()
    }
}

protocol GitHubLinkViewDelegate: class {
    func didTapLinkViewButton()
}
