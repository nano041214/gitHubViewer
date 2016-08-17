#import <FontAwesomeKit/FontAwesomeKit.h>
#import "GUVActivitiesViewController.h"
#import "GUVActivity.h"
#import "GUVActivityTableViewCell.h"
#import "GUVAPIClient.h"
#import "GUVUserInfoHeaderView.h"
#import "GUVUserProfileViewController.h"

static const CGFloat IconSize = 22;

@interface GUVActivitiesViewController ()

@property (weak, nonatomic) IBOutlet GUVUserInfoHeaderView *userInfoHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray<GUVActivity *> *activities;
@property (nonatomic, weak) id<GUVUserProvider> provider;
@property (weak, nonatomic) IBOutlet UIView *errorMassageWrapperView;
@property (weak, nonatomic) IBOutlet UILabel *errorMessageLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *inquiryViewAppearButton;

@end

@implementation GUVActivitiesViewController

- (void)viewDidLoad {
    FAKFontAwesome *githubIcon = [FAKFontAwesome githubIconWithSize:IconSize];
    self.inquiryViewAppearButton.image = [githubIcon imageWithSize:CGSizeMake(IconSize, IconSize)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSAssert([self.tabBarController isKindOfClass:[GUVUserInfoTabBarController class]], @"tabBarController is of class %@, not of the expected class GUVUserInfoTabBarController", [self.tabBarController class]);
    self.provider = (GUVUserInfoTabBarController *)self.tabBarController;
    self.userInfoHeaderView.user = self.provider.fetchedUser;

    GUVAPIClient *client = [GUVAPIClient sharedClient];
    [client requestActivitiesInfo:self.provider.fetchedUser.name completionBlock:^(NSArray<GUVActivity *> * _Nullable activities, NSError * _Nullable error) {
        if (activities.count != 0) {
            [self showTableView];
            self.activities = activities;
            [self.tableView reloadData];
        } else {
            [self showErrorMessageViewWithMessage:error];
        }
    }];
}

- (void)showTableView {
    self.tableView.hidden = NO;
    self.errorMassageWrapperView.hidden = YES;
}

- (void)showErrorMessageViewWithMessage:(NSError *_Nullable)error {
    if (error != nil) {
        self.errorMessageLabel.text = error.localizedDescription;
    }
    self.tableView.hidden = YES;
    self.errorMassageWrapperView.hidden = NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GUVUserProfileViewController *userProfileViewController = segue.destinationViewController;
    userProfileViewController.provider = self.provider;
}

- (IBAction)didTapInquiryViewAppearButton:(UIBarButtonItem *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GUVInquiryViewController *inquiryViewController = [storyboard instantiateViewControllerWithIdentifier:@"GUVInquiryViewController"];
    NSAssert([self.tabBarController isKindOfClass:[GUVUserInfoTabBarController class]], @"tabBarController is of class %@, not of the expected class GUVUserInfoTabBarController", [self.tabBarController class]);
    inquiryViewController.delegate = (GUVUserInfoTabBarController *)self.tabBarController;
    [self presentViewController:inquiryViewController animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.activities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GUVActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell" forIndexPath:indexPath];
    cell.activity = self.activities[indexPath.item];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Activities";
}

@end
