#import "GUVInquiryViewController.h"
#import "GUVUserInfoTabBarController.h"
#import "GUVUser.h"
#import "GUVAPIClient.h"
#import <SVProgressHUD.h>

@interface GUVInquiryViewController ()

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

@end

@implementation GUVInquiryViewController

- (IBAction)textFieldValueDidChange:(UITextField *)sender {
    self.alertLabel.hidden = TRUE;
}


- (IBAction)userNameDidEdit:(UITextField *)sender {
    [SVProgressHUD show];

    GUVAPIClient *client = [GUVAPIClient sharedGHAPIClient];
    [client requestUserInfo:sender.text successBlock:^(GUVUser *user, NSError *error) {
        [SVProgressHUD dismiss];
        // segue
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GUVUserInfoTabBarController *usersInfoTabBarController = [storyboard instantiateViewControllerWithIdentifier:@"GUVUsersInfoTabBarController"];
        usersInfoTabBarController.user = user;
        [self.navigationController pushViewController:usersInfoTabBarController animated:NO];
    } failureBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
        self.alertLabel.hidden = FALSE;
    }];
}

@end
