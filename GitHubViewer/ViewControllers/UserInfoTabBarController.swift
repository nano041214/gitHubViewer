import UIKit

class UserInfoTabBarController: UITabBarController, UserProvider, InquiryViewControllerDelegate {
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        let repositoriesViewController: RepositoriesViewController = ghv_instantiateViewController()
        let activitiesViewController: ActivitiesViewController = ghv_instantiateViewController()

        activitiesViewController.userProvider = self
        repositoriesViewController.userProvider = self

        let repositoriesContainerController = UINavigationController(rootViewController: repositoriesViewController)
        repositoriesContainerController.title = "Repos"
        let activitiesContainerController = UINavigationController(rootViewController: activitiesViewController)
        activitiesContainerController.title = "Activities"

        viewControllers = [repositoriesContainerController, activitiesContainerController]
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if user == nil {
            showInquiryViewController()
        }
    }

    // MARK: - InquiryViewControllerDelegate

    func inquiryViewController(inquiryViewController: InquiryViewController, userWasSelected user: User) {
        self.user = user
    }

    // MARK: - UserProvider

    func showInquiryViewController() {
        let inquiryViewController: InquiryViewController = ghv_instantiateViewController()
        inquiryViewController.delegate = self
        presentViewController(inquiryViewController, animated: true, completion: nil)
    }
}

protocol UserProvider: class {
    var user: User? { get }
    func showInquiryViewController()
}
