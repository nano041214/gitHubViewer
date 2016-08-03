#import "GUVInquiryViewController.h"
#import "GUVUserInfoTabBarController.h"
#import "GUVUser.h"
#import "GUVAPIClient.h"
#import <SVProgressHUD.h>

@interface GUVInquiryViewController ()

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet UILabel *suggestionLabel;

@end

@implementation GUVInquiryViewController

- (IBAction)textFieldValueDidChange:(UITextField *)sender {
    self.alertLabel.hidden = YES;
    self.suggestionLabel.hidden = YES;
}

- (IBAction)userNameDidEdit:(UITextField *)sender {
    [SVProgressHUD show];

    GUVAPIClient *client = [GUVAPIClient sharedClient];
    [client requestUserInfo:sender.text successBlock:^(GUVUser *user) {
        [SVProgressHUD dismiss];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GUVUserInfoTabBarController *usersInfoTabBarController = [storyboard instantiateViewControllerWithIdentifier:@"GUVUsersInfoTabBarController"];
        usersInfoTabBarController.user = user;
        [self.navigationController pushViewController:usersInfoTabBarController animated:NO];
    } failureBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self showAlertLabel:error];
    }];
}

- (void)showAlertLabel:(NSError *)error {
    self.alertLabel.hidden = NO;
    self.alertLabel.text = [NSString stringWithFormat:@"%@ %@", error.localizedDescription, error.localizedRecoverySuggestion];
    self.suggestionLabel.hidden = YES;
}

@end
