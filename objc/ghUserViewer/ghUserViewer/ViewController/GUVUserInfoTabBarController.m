#import "GUVUserInfoTabBarController.h"
#import "FontAwesomeKit/FontAwesomeKit.h"
#import "GUVInquiryViewController.h"
#import "GUVRepositoriesViewController.h"
#import "GUVUserInfoHeaderView.h"

static const CGFloat IconSize = 20;

@interface GUVUserInfoTabBarController ()

@property (weak, nonatomic) IBOutlet GUVRepositoriesViewController *repositoriesViewController;

@end

@implementation GUVUserInfoTabBarController

- (void)viewDidLoad {

    // tab settings
    FAKFontAwesome *repositoriesIcon = [FAKFontAwesome databaseIconWithSize:IconSize];
    UITabBarItem *repositoriesItem = self.tabBar.items[0];
    repositoriesItem.image = [repositoriesIcon imageWithSize:CGSizeMake(IconSize, IconSize)];
    FAKFontAwesome *activitiesIcon = [FAKFontAwesome rssIconWithSize:IconSize];
    UITabBarItem *activitiesItem = self.tabBar.items[1];
    activitiesItem.image = [activitiesIcon imageWithSize:CGSizeMake(IconSize, IconSize)];

    // pass user instance
    self.repositoriesViewController.user = self.user;
}

@end
