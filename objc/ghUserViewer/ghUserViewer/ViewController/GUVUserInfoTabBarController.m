#import "GUVUserInfoTabBarController.h"
#import "FontAwesomeKit/FontAwesomeKit.h"
#import "GUVInquiryViewController.h"
#import "GUVRepositoriesViewController.h"
#import "GUVUserInfoHeaderView.h"

static const CGFloat IconSize = 20;

@interface GUVUserInfoTabBarController ()

@end

@implementation GUVUserInfoTabBarController
@synthesize user;

- (void)viewDidLoad {

    [super viewDidLoad];

    // tab settings
    FAKFontAwesome *repositoriesIcon = [FAKFontAwesome databaseIconWithSize:IconSize];
    UITabBarItem *repositoriesItem = self.tabBar.items[0];
    repositoriesItem.image = [repositoriesIcon imageWithSize:CGSizeMake(IconSize, IconSize)];
    FAKFontAwesome *activitiesIcon = [FAKFontAwesome rssIconWithSize:IconSize];
    UITabBarItem *activitiesItem = self.tabBar.items[1];
    activitiesItem.image = [activitiesIcon imageWithSize:CGSizeMake(IconSize, IconSize)];

    // pass user instance
    for (id<GUVUserProvider> viewController in self.viewControllers) {
        viewController.user = self.user;
    }
}

@end
