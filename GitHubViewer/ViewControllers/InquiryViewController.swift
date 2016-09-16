import APIKit
import SnapKit
import UIKit

class InquiryViewController: UIViewController {
    weak var delegate: InquiryViewControllerDelegate?
    
    @IBOutlet weak var variableHeightViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var alertLabel: UILabel!



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
}

protocol InquiryViewControllerDelegate: class {
    func inquiryViewController(inquiryViewController: InquiryViewController, userWasSelected user: User)
}
