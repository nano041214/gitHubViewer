import APIKit
import SnapKit
import UIKit

class InquiryViewController: UIViewController {
    weak var delegate: InquiryViewControllerDelegate?

    @IBOutlet weak var variableHeightViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var alertLabel: UILabel!

    override func viewDidLoad() {
        let defaultCenter = NSNotificationCenter.defaultCenter()
        defaultCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        defaultCenter.addObserver(self, selector: #selector(keyboardDidHide), name: UIKeyboardWillHideNotification, object: nil)
    }

    deinit {
        let defaultCenter = NSNotificationCenter.defaultCenter()
        defaultCenter.removeObserver(self)
    }

    @IBAction func didChangeTextFieldValue(sender: UITextField) {
        alertLabel.hidden = true
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
                self.alertLabel.hidden = false
                self.alertLabel.text = String(error)
            }
        }
    }

    // workaround
    func keyboardWillShow() {
        variableHeightViewHeightConstraint.constant = 200.0
        view.layoutIfNeeded()
    }

    func keyboardDidHide() {
        variableHeightViewHeightConstraint.constant = 0
        view.layoutIfNeeded()
    }
}

protocol InquiryViewControllerDelegate: class {
    func inquiryViewController(inquiryViewController: InquiryViewController, userWasSelected user: User)
}
