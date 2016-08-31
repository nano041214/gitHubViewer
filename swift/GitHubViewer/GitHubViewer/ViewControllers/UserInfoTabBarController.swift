import UIKit

class UserInfoTabBarController: UITabBarController, UserProvider, InquiryViewControllerDelegate {
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let repositoriesViewController = storyboard?.instantiateViewControllerWithIdentifier("RepositoriesViewController") as? RepositoriesViewController else {
            fatalError("Could not load RepositoriesViewController")
        }
        guard let activitiesViewController = storyboard?.instantiateViewControllerWithIdentifier("ActivitiesViewController") as? ActivitiesViewController else {
            fatalError("Could not load ActivitiesViewController")
        }

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
            guard let inquiryViewController = storyboard?.instantiateViewControllerWithIdentifier("InquiryViewController") as? InquiryViewController else {
                fatalError("Could not load RepositoriesViewController")
            }
            inquiryViewController.delegate = self
            presentViewController(inquiryViewController, animated: true, completion: nil)
        }
    }

    // MARK: - InquiryViewControllerDelegate

    func inquiryViewController(inquiryViewController: InquiryViewController, userWasSelected user: User) {
        self.user = user
    }
}

protocol UserProvider {
    var user: User? { get }
}
