#import "GUVUserInfoTabBarController.h"
#import "FontAwesomeKit/FontAwesomeKit.h"
#import "GUVInquiryViewController.h"
#import "GUVRepositoriesViewController.h"
#import "GUVUserInfoHeaderView.h"
#import <AFNetworking.h>

static const CGFloat IconSize = 20;

@interface GUVUserInfoTabBarController ()

@end

@implementation GUVUserInfoTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    // tab settings
    FAKFontAwesome *repositoriesIcon = [FAKFontAwesome databaseIconWithSize:IconSize];
    UITabBarItem *repositoriesItem = self.tabBar.items[0];
    repositoriesItem.image = [repositoriesIcon imageWithSize:CGSizeMake(IconSize, IconSize)];
    FAKFontAwesome *activitiesIcon = [FAKFontAwesome rssIconWithSize:IconSize];
    UITabBarItem *activitiesItem = self.tabBar.items[1];
    activitiesItem.image = [activitiesIcon imageWithSize:CGSizeMake(IconSize, IconSize)];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://api.github.com/users/nano041214" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        self.user = [MTLJSONAdapter modelOfClass:GUVUser.class
                          fromJSONDictionary:responseDictionary error:nil];
        NSLog(@"%@", self.user);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(GUVUser *)fetchUser {
    return self.user;
}

@end
