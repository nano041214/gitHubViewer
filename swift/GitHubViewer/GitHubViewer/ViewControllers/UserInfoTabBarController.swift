import UIKit

class UserInfoTabBarController: UITabBarController, UserProvider, InquiryViewControllerDelegate {
    var user: User?

    private func instantiateViewController<ViewControllerType: UIViewController>() -> ViewControllerType {
        let className = String(ViewControllerType)
        guard let viewController = storyboard?.instantiateViewControllerWithIdentifier(className) as? ViewControllerType else {
            fatalError("Could not load \(ViewControllerType.self)")
        }
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repositoriesViewController: RepositoriesViewController = instantiateViewController()
        let activitiesViewController: ActivitiesViewController = instantiateViewController()

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
            let inquiryViewController: InquiryViewController = instantiateViewController()
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
