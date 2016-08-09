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
    self.alertLabel.hidden = YES;
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
        [self showAlertLabelwithError:error];
    }];
}

- (void)showAlertLabelwithError:(NSError *)error {
    self.alertLabel.hidden = NO;
    if ( error.localizedRecoverySuggestion != nil ) {
        NSString *localizedDescription = NSLocalizedString(error.localizedDescription, nil);
        NSString *localizedRecoverySuggestion = NSLocalizedString(error.localizedRecoverySuggestion, nil);
        self.alertLabel.text = [NSString stringWithFormat:@"%@\n%@", localizedDescription, localizedRecoverySuggestion];
    } else {
        self.alertLabel.text = error.localizedDescription;
    }
}

@end
