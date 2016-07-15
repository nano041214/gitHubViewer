#import "GUVInquiryViewController.h"
#import "GUVUserInfoTabBarController.h"


@interface GUVInquiryViewController ()
@end

@implementation GUVInquiryViewController

- (IBAction)userNameDidEdit:(UITextField *)sender {
    _user = [GUVUser new];
    self.user.name = sender.text;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GUVUserInfoTabBarController *userInfoTabBarController = segue.destinationViewController;
    userInfoTabBarController.user = self.user;
}

@end
