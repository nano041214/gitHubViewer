#import <ChameleonFramework/Chameleon.h>
#import <FontAwesomeKit/FontAwesomeKit.h>
#import <SVProgressHUD.h>
#import "GUVInquiryViewController.h"
#import "GUVUserInfoTabBarController.h"
#import "GUVUser.h"
#import "GUVAPIClient.h"

static const CGFloat IconSize = 22;

@interface GUVInquiryViewController ()

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wrapperViewMarginBottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@implementation GUVInquiryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    FAKFontAwesome *closeIcon = [FAKFontAwesome closeIconWithSize:IconSize];
    [closeIcon addAttribute:NSForegroundColorAttributeName value:[UIColor
                                                                 flatMintColor]];
    [self.closeButton setBackgroundImage:[closeIcon imageWithSize:CGSizeMake(IconSize, IconSize)] forState:UIControlStateNormal];
}

- (IBAction)textFieldValueDidChange:(UITextField *)sender {
    self.alertLabel.hidden = YES;
}

- (IBAction)userNameDidEdit:(UITextField *)sender {
    [SVProgressHUD show];

    GUVAPIClient *client = [GUVAPIClient sharedClient];
    [client requestUserInfo:sender.text completionBlock:^(GUVUser * _Nullable user, NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        if (error != nil) {
            [self showAlertLabelWithError:error];
        } else {
            [self.delegate viewController:self userWasSelected:user];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)showAlertLabelWithError:(NSError *)error {
    self.alertLabel.hidden = NO;
    if ( error.localizedRecoverySuggestion != nil ) {
        self.alertLabel.text = [NSString stringWithFormat:@"%@\n%@", error.localizedDescription, error.localizedRecoverySuggestion];
    } else {
        self.alertLabel.text = error.localizedDescription;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    CGRect keyboardFrame = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardCGRectGetHeight = keyboardFrame.size.height;
    CGRect deviceFrame = [[UIScreen mainScreen] bounds];
    CGFloat deviceCGRectGetHeight = deviceFrame.size.height;

    CGFloat keyboardOffsetHeight = deviceCGRectGetHeight - keyboardCGRectGetHeight;

    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat statusBarCGRectGetHeight = statusBarFrame.size.height;
    CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
    CGFloat navigationBarCGRectGetHeight = navigationBarFrame.size.height;

    CGRect userNameTextFieldFrame = self.userNameTextField.frame;
    CGFloat userNameTextFieldCGRectGetY = userNameTextFieldFrame.origin.y;
    CGFloat userNameTextFieldCGRectGetHeight = userNameTextFieldFrame.size.height;

    CGFloat textFieldBottomOffsetHeight = statusBarCGRectGetHeight + navigationBarCGRectGetHeight + userNameTextFieldCGRectGetY + userNameTextFieldCGRectGetHeight;

    if (textFieldBottomOffsetHeight > keyboardOffsetHeight) {
        CGFloat scrollOffset = textFieldBottomOffsetHeight - keyboardOffsetHeight;
        self.wrapperViewMarginBottomConstraint.constant = scrollOffset;
        NSTimeInterval duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

        // Wondering why it works with any duration value.
        [UIView animateWithDuration:duration
                         animations:^{
                             [self.view layoutIfNeeded];
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.wrapperViewMarginBottomConstraint.constant = 0.0;
    NSTimeInterval duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}

- (IBAction)didTapContentView:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)didTouchTextFieldCancel:(UITextField *)sender {
    [self.view endEditing:YES];
}

- (IBAction)didTapCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
