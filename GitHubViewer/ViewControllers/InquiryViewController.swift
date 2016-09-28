import APIKit
import FontAwesome
import UIKit

class InquiryViewController: UIViewController {
    weak var delegate: InquiryViewControllerDelegate?
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var variableHeightViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var alertLabel: UILabel!

    let closeButtonFontSize: CGFloat = 30.0

    override func viewDidLoad() {
        closeButton.titleLabel?.font = UIFont.fontAwesomeOfSize(closeButtonFontSize)
        closeButton.setTitle(String.fontAwesomeIconWithName(.Close), forState: .Normal)

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
                switch error {
                case .ResponseError(let gitHubError as GitHubViewerError):
                    self.alertLabel.text = "GitHub API Error: \(gitHubError.errorDescription)"
                default:
                    self.alertLabel.text = String(String(error).componentsSeparatedByString("\"")[1])
                }
            }
        }
    }

    @IBAction func didTapContainerView(sender: AnyObject) {
        view.endEditing(false)
    }

    func keyboardWillShow(notification: NSNotification) {
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval else {
            return
        }

        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() else {
            return
        }
        let keyboardHeight = keyboardFrame.height
        let deviceFrame = UIScreen.mainScreen().bounds
        let deviceHeight = deviceFrame.height

        let keyboardOffsetHeight = deviceHeight - keyboardHeight

        let statusBarFrame = UIApplication.sharedApplication().statusBarFrame
        let statusBartHeight = statusBarFrame.height
        let userNameTextFieldFrame = userNameTextField.frame
        let userNameTextFieldOriginY = userNameTextFieldFrame.origin.y
        let userNameTextFieldHeight = userNameTextFieldFrame.height

        let textFieldBottomOffsetHeight = statusBartHeight + userNameTextFieldOriginY + userNameTextFieldHeight

        if textFieldBottomOffsetHeight > keyboardOffsetHeight {
            let marginBottom: CGFloat = 30.0
            let scrollOffset = textFieldBottomOffsetHeight - keyboardOffsetHeight + marginBottom
            variableHeightViewHeightConstraint.constant = scrollOffset

            UIView.animateWithDuration(duration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        variableHeightViewHeightConstraint.constant = 0.0
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval else {
            return
        }
        UIView.animateWithDuration(duration, animations: {
            self.view.layoutIfNeeded()
        })
    }

    @IBAction func didTapCloseButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

protocol InquiryViewControllerDelegate: class {
    func inquiryViewController(inquiryViewController: InquiryViewController, userWasSelected user: User)
}
