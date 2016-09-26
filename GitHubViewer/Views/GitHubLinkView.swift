import UIKit

class GitHubLinkView: UITableViewHeaderFooterView {
    static let height: CGFloat = 65.0
    weak var delegate: GitHubLinkViewDelegate?

    @IBAction func didTapLinkViewButton(sender: AnyObject) {
        delegate?.didTapLinkViewButton(self)
    }
}

protocol GitHubLinkViewDelegate: class {
    func didTapLinkViewButton(gitHubLinkView: GitHubLinkView)
}
