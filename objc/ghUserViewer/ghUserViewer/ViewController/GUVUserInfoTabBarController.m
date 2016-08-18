#import <ChameleonFramework/Chameleon.h>
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
    GUVActivitiesViewController *activitiesViewController = [storyboard instantiateViewControllerWithIdentifier:@"GUVActivitiesViewController"];
    activitiesViewController.userProvider = self;

    UINavigationController *repositoriesContainerNavigationController = [[UINavigationController alloc] initWithRootViewController:repositoriesViewController];
    UINavigationController *activitiesContainerNavigationController = [[UINavigationController alloc] initWithRootViewController:activitiesViewController];

    [self setViewControllers:@[repositoriesContainerNavigationController, activitiesContainerNavigationController] animated:NO];

    [self setTabBarAppearance];
    [self setNavigationBarAppearance];
    [self setButonAppearance];
    [self setTableAppearance];
    FAKFontAwesome *repositoriesIcon = [FAKFontAwesome databaseIconWithSize:IconSize];
    [repositoriesIcon addAttribute:NSForegroundColorAttributeName value:[UIColor
                                                                 flatMintColorDark]];
    UITabBarItem *repositoriesItem = self.tabBar.items[0];
    repositoriesItem.image = [repositoriesIcon imageWithSize:CGSizeMake(IconSize, IconSize)];
    FAKFontAwesome *activitiesIcon = [FAKFontAwesome rssIconWithSize:IconSize];
    [activitiesIcon addAttribute:NSForegroundColorAttributeName value:[UIColor
                                                                         flatMintColorDark]];
    UITabBarItem *activitiesItem = self.tabBar.items[1];
    activitiesItem.image = [activitiesIcon imageWithSize:CGSizeMake(IconSize, IconSize)];
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


#pragma mark - Appearance

- (void)setTabBarAppearance {
    [UITabBar appearance].barTintColor = [UIColor flatMintColor];
    [UITabBar appearance].tintColor = [UIColor flatWhiteColor];
}

- (void)setNavigationBarAppearance {
    [UINavigationBar appearance].backgroundColor = [UIColor flatMintColor];
    [UIBarButtonItem appearance].tintColor = [UIColor flatWatermelonColor];
}

- (void)setButonAppearance {
    [[UIButton appearance] setTitleColor:[UIColor flatMintColor] forState:UIControlStateNormal];
}

- (void)setTableAppearance {
    [UITableView appearance].sectionIndexBackgroundColor = [UIColor flatMintColor];
}

@end
