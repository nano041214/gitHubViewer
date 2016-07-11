#import "GUVUserInfoTabBarController.h"
#import "FontAwesomeKit/FontAwesomeKit.h"
#import "GUVInquiryViewController.h"

static const CGFloat IconSize = 20;

@implementation GUVUserInfoTabBarController

- (void)viewDidLoad {
    FAKFontAwesome *repositoriesIcon = [FAKFontAwesome databaseIconWithSize:IconSize];
    UITabBarItem *repositoriesItem = self.tabBar.items[0];
    repositoriesItem.image = [repositoriesIcon imageWithSize:CGSizeMake(IconSize, IconSize)];
    FAKFontAwesome *activitiesIcon = [FAKFontAwesome rssIconWithSize:IconSize];
    UITabBarItem *activitiesItem = self.tabBar.items[1];
    activitiesItem.image = [activitiesIcon imageWithSize:CGSizeMake(IconSize, IconSize)];
}

@end