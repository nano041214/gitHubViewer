import UIKit

class UserInfoTabBarController: UITabBarController, UserProvider, InquiryViewControllerDelegate {
    var user: User? {
        didSet {
            repositoriesViewController.setOtherUser()
            activitiesViewController.setOtherUser()
        }
    }
    let barItemImageSize = CGSize(width: 30.0, height: 30.0)
    let whiteCollor = UIColor.flatWhiteColor()

    var repositoriesViewController: RepositoriesViewController!
    var activitiesViewController: ActivitiesViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        let repositoriesViewController: RepositoriesViewController = ghv_instantiateViewController()
        let activitiesViewController: ActivitiesViewController = ghv_instantiateViewController()

        repositoriesViewController.userProvider = self
        activitiesViewController.userProvider = self

        self.repositoriesViewController = repositoriesViewController
        self.activitiesViewController = activitiesViewController

        let repositoriesContainerController = UINavigationController(rootViewController: repositoriesViewController)
        repositoriesContainerController.title = "Repos"
        repositoriesContainerController.tabBarItem.image = UIImage.fontAwesomeIconWithName(.Database, textColor: whiteCollor, size: barItemImageSize)
        let activitiesContainerController = UINavigationController(rootViewController: activitiesViewController)
        activitiesContainerController.tabBarItem.image = UIImage.fontAwesomeIconWithName(.RSS, textColor: whiteCollor, size: barItemImageSize)
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
