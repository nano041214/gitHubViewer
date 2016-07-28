#import "GUVInquiryViewController.h"
#import "GUVUserInfoTabBarController.h"
#import "GUVUser.h"
#import "GUVAPIClient.h"
#import <SVProgressHUD.h>

@interface GUVInquiryViewController ()

@end

@implementation GUVInquiryViewController

- (IBAction)userNameDidEdit:(UITextField *)sender {
    [SVProgressHUD show];

    GUVAPIClient *client = [GUVAPIClient sharedGHAPIClient];
    [client requestUserInfo:sender.text successBlock:^(GUVUser *user, NSError *error) {
        [SVProgressHUD dismiss];
        _user = user;
        NSLog(@"%@", self.user);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GUVUserInfoTabBarController *usersInfoTabBarController = [storyboard instantiateViewControllerWithIdentifier:@"GUVUsersInfoTabBarController"];
        usersInfoTabBarController.user = self.user;
        [self.navigationController pushViewController:usersInfoTabBarController animated:NO];
    } failureBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

@end
