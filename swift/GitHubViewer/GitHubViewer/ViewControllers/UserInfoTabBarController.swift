import UIKit

class UserInfoTabBarController: UITabBarController, UserProvider {
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let repositoriesViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RepositoriesViewController") as? RepositoriesViewController else {
            fatalError("Could not load RepositoriesViewController")
        }
        guard let activitiesViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ActivitiesViewController") as? ActivitiesViewController else {
            fatalError("Could not load ActivitiesViewController")
        }

        activitiesViewController.userProvider = self
        repositoriesViewController.userProvider = self

        let repositoriesContainerController = UINavigationController(rootViewController: repositoriesViewController)
        repositoriesContainerController.title = "Repos"
        let activitiesContainerController = UINavigationController(rootViewController: activitiesViewController)
        activitiesContainerController.title = "Activities"

        self.viewControllers = [repositoriesContainerController, activitiesContainerController]
    }

}

protocol UserProvider {
    var user: User! { get }
}
