#import "GUVInquiryViewController.h"

@interface GUVInquiryViewController ()
@end

@implementation GUVInquiryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)inquiredUserInfo:(UITextField *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *usersInfoTabBarController = [storyboard instantiateViewControllerWithIdentifier:@"GUVUsersInfoTabBarController"];
    [self.navigationController pushViewController:usersInfoTabBarController animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
