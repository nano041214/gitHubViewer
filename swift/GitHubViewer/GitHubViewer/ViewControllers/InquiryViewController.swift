import UIKit
import APIKit

class InquiryViewController: UIViewController {
    // it always exist but cannot be set in initializer because initialized by storyboard
    var delegate: InquiryViewControllerDelegate!

    @IBAction func didEnterUserName(sender: UITextField) {
        guard let userNameString = sender.text else {
            return
        }
        let request = UserRequest(userName: userNameString)
        Session.sendRequest(request) { result in
            switch result {
            case .Success(let response):
                self.delegate.inquiryViewController(self, userWasSelected: response)
                self.dismissViewControllerAnimated(true, completion: nil)
            case .Failure(let error):
                print(error)
            }
        }
    }
}

protocol InquiryViewControllerDelegate {
    func inquiryViewController(inquiryViewController: InquiryViewController, userWasSelected user: User)
}
