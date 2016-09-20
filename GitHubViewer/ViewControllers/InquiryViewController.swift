import UIKit
import APIKit
import FontAwesome

class InquiryViewController: UIViewController {
    weak var delegate: InquiryViewControllerDelegate?
    @IBOutlet weak var closeButton: UIButton!

    override func viewDidLoad() {
        closeButton.titleLabel?.font = UIFont.fontAwesomeOfSize(30)
        closeButton.setTitle(String.fontAwesomeIconWithName(.Close), forState: .Normal)
    }

    @IBAction func didEnterUserName(sender: UITextField) {
        guard let userNameString = sender.text else {
            return
        }
        let request = UserRequest(userName: userNameString)
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let user):
                self.delegate?.inquiryViewController(self, userWasSelected: user)
                self.dismissViewControllerAnimated(true, completion: nil)
            case .Failure(let error):
                print(error)
                assertionFailure("Should display an error message")
            }
        }
    }
}

protocol InquiryViewControllerDelegate: class {
    func inquiryViewController(inquiryViewController: InquiryViewController, userWasSelected user: User)
}
