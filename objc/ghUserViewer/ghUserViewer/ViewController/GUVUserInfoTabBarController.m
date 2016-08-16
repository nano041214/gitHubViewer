#import <FontAwesomeKit/FontAwesomeKit.h>
#import "GUVUserInfoTabBarController.h"
#import "GUVInquiryViewController.h"

static const CGFloat IconSize = 20;

@interface GUVUserInfoTabBarController ()

@property (nonatomic) GUVInquiryViewController *inquryViewController;

@end

@implementation GUVUserInfoTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    FAKFontAwesome *repositoriesIcon = [FAKFontAwesome databaseIconWithSize:IconSize];
    UITabBarItem *repositoriesItem = self.tabBar.items[0];
    repositoriesItem.image = [repositoriesIcon imageWithSize:CGSizeMake(IconSize, IconSize)];
    FAKFontAwesome *activitiesIcon = [FAKFontAwesome rssIconWithSize:IconSize];
    UITabBarItem *activitiesItem = self.tabBar.items[1];
    activitiesItem.image = [activitiesIcon imageWithSize:CGSizeMake(IconSize, IconSize)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.user == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.inquryViewController = [storyboard instantiateViewControllerWithIdentifier:@"GUVInquiryViewController"];
        self.inquryViewController.delegate = self;
        [self showViewController:self.inquryViewController sender:self];
    }
}

# pragma mark GUVUserProvider

- (GUVUser *)fetchUser {
    return self.user;
}

# pragma mark GUVInquiryViewControllerDelegate

- (void)viewController:(GUVInquiryViewController *)viewController userWasSelected:(GUVUser *)user {
    self.user = user;
}

- (void)setUser:(GUVUser *)user {
    _user = user;
    for (id viewController in self.childViewControllers) {
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navigationController = (UINavigationController *)viewController;
            if ([navigationController.childViewControllers[0] conformsToProtocol:@protocol(GUVUserObserver)]) {
                [navigationController.childViewControllers[0] userDidUpdate:self];
            }
        }
    }
}

@end
