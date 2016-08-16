#import "GUVUserInfoTabBarController.h"
#import "GUVInquiryViewController.h"
#import <FontAwesomeKit/FontAwesomeKit.h>

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.user == nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.inquryViewController = [storyboard instantiateViewControllerWithIdentifier:@"GUVInquiryViewController"];
        self.inquryViewController.delegate = self;
        [self showViewController:self.inquryViewController sender:self];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (GUVUser *)fetchUser {
    return self.user;
}

- (void)provideUser:(GUVInquiryViewController *)inquiryViewController user:(GUVUser *)user {
    self.user = user;
}

@end
