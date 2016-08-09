#import "GUVInquiryViewController.h"
#import "GUVUserInfoTabBarController.h"
#import "GUVUser.h"
#import "GUVAPIClient.h"
#import <SVProgressHUD.h>

static const CGFloat TextFieldMarginBottom = 20.0;

@interface GUVInquiryViewController ()

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *viewWrapperScrollView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@end

@implementation GUVInquiryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

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
        self.alertLabel.text = [NSString stringWithFormat:@"%@\n%@", error.localizedDescription, error.localizedRecoverySuggestion];
    } else {
        self.alertLabel.text = error.localizedDescription;
    }
}

-(void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    CGRect keyboardFrame = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    CGRect deviceFrame = [[UIScreen mainScreen] bounds];
    CGFloat deviceHeight = deviceFrame.size.height;

    CGFloat keyboardOffsetHeight = deviceHeight - keyboardHeight;

    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat statusBarHeight = statusBarFrame.size.height;
    CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
    CGFloat navigationBarHeight = navigationBarFrame.size.height;

    CGRect userNameTextFieldFrame = self.userNameTextField.frame;
    CGFloat userNameTextFieldOriginY = userNameTextFieldFrame.origin.y;
    CGFloat userNameTextFieldHeight = userNameTextFieldFrame.size.height;

    CGFloat textFieldBottomOffsetHeight = statusBarHeight + navigationBarHeight + userNameTextFieldOriginY + userNameTextFieldHeight;

    if (textFieldBottomOffsetHeight > keyboardOffsetHeight) {
        CGFloat scrollScale = textFieldBottomOffsetHeight - keyboardOffsetHeight + TextFieldMarginBottom;
        [self.viewWrapperScrollView setContentOffset:CGPointMake(0.0, scrollScale) animated:YES];
    }
}

- (IBAction)didTapContentView:(id)sender {
    [self.viewWrapperScrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
    [self.view endEditing:YES];
}

@end
