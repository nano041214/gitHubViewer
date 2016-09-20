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
        defaultCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
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
                self.alertLabel.hidden = false
                self.alertLabel.text = String(error)
            }
        }
    }

    // workaround
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() else {
            fatalError("NSNotification has invalid userInfo")
        }
        let keyboardCGRectGetHeight = keyboardFrame.size.height
        let deviceFrame = UIScreen.mainScreen().bounds
        let deviceCGRectGetHeight = deviceFrame.size.height

        let keyboardOffsetHeight = deviceCGRectGetHeight - keyboardCGRectGetHeight

        let statusBarFrame = UIApplication.sharedApplication().statusBarFrame
        let statusBarCGRectGetHeight = statusBarFrame.size.height
        let userNameTextFieldFrame = userNameTextField.frame
        let userNameTextFieldCGRectGetY = userNameTextFieldFrame.origin.y
        let userNameTextFieldCGRectGetHeight = userNameTextFieldFrame.size.height

        let textFieldBottomOffsetHeight = statusBarCGRectGetHeight + userNameTextFieldCGRectGetY + userNameTextFieldCGRectGetHeight

        if textFieldBottomOffsetHeight > keyboardOffsetHeight {
            let marginBottom: CGFloat = 30.0
            let scrollOffset = textFieldBottomOffsetHeight - keyboardOffsetHeight + marginBottom
            variableHeightViewHeightConstraint.constant = scrollOffset

            guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval else {
                fatalError("NSNotification has invalid userInfo")
            }
            UIView.animateWithDuration(duration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        variableHeightViewHeightConstraint.constant = 0.0
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval else {
            fatalError("NSNotification has invalid userInfo")
        }
        UIView.animateWithDuration(duration, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

protocol InquiryViewControllerDelegate: class {
    func inquiryViewController(inquiryViewController: InquiryViewController, userWasSelected user: User)
}
