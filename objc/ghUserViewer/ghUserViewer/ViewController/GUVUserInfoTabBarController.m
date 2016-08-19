#import <FontAwesomeKit/FontAwesomeKit.h>
#import "GUVUserInfoTabBarController.h"
#import "GUVInquiryViewController.h"
#import "GUVRepositoriesViewController.h"
#import "GUVActivitiesViewController.h"

static const CGFloat IconSize = 20;

@interface GUVUserInfoTabBarController ()

@property (nonatomic) GUVInquiryViewController *inquryViewController;

@property (nonatomic, nullable) GUVUser *user;

@end

@implementation GUVUserInfoTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GUVRepositoriesViewController *repositoriesViewController = [storyboard instantiateViewControllerWithIdentifier:@"GUVRepositoriesViewController"];
    repositoriesViewController.userProvider = self;
    FAKFontAwesome *repositoriesIcon = [FAKFontAwesome databaseIconWithSize:IconSize];
    repositoriesViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Repos" image:[repositoriesIcon imageWithSize:CGSizeMake(IconSize, IconSize)] selectedImage:nil];
    GUVActivitiesViewController *activitiesViewController = [storyboard instantiateViewControllerWithIdentifier:@"GUVActivitiesViewController"];
    activitiesViewController.userProvider = self;
    FAKFontAwesome *activitiesIcon = [FAKFontAwesome rssIconWithSize:IconSize];
    activitiesViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Activities" image:[activitiesIcon imageWithSize:CGSizeMake(IconSize, IconSize)]  selectedImage:nil];

    UINavigationController *repositoriesContainerNavigationController = [[UINavigationController alloc] initWithRootViewController:repositoriesViewController];
    UINavigationController *activitiesContainerNavigationController = [[UINavigationController alloc] initWithRootViewController:activitiesViewController];

    [self setViewControllers:@[repositoriesContainerNavigationController, activitiesContainerNavigationController] animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.user == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.inquryViewController = [storyboard instantiateViewControllerWithIdentifier:@"GUVInquiryViewController"];
        self.inquryViewController.delegate = self;
        [self presentViewController:self.inquryViewController animated:YES completion:nil];
    }
}

# pragma mark - GUVUserProvider

- (GUVUser *)fetchedUser {
    return self.user;
}

# pragma mark - GUVInquiryViewControllerDelegate

- (void)viewController:(GUVInquiryViewController *)viewController userWasSelected:(GUVUser *)user {
    self.user = user;
}

@end
