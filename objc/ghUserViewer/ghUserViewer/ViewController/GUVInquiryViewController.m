#import "GUVInquiryViewController.h"

@interface GUVInquiryViewController ()
@end

@implementation GUVInquiryViewController

- (IBAction)userNameDidEdit:(UITextField *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *usersInfoTabBarController = [storyboard instantiateViewControllerWithIdentifier:@"GUVUsersInfoTabBarController"];
    [self.navigationController pushViewController:usersInfoTabBarController animated:NO];
}

@end
