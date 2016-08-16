#import "GUVUserInfoTabBarController.h"
#import "GUVInquiryViewController.h"
#import <FontAwesomeKit/FontAwesomeKit.h>

static const CGFloat IconSize = 20;

@interface GUVUserInfoTabBarController ()

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.user == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GUVInquiryViewController *inquiryViewController = [storyboard instantiateViewControllerWithIdentifier:@"GUVInquiryViewController"];
        [self showViewController:inquiryViewController sender:self];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (GUVUser *)fetchUser {
    return self.user;
}

@end
