#import <FontAwesomeKit/FontAwesomeKit.h>
#import "GUVInquiryViewController.h"
#import "GUVRepositoriesViewController.h"
#import "GUVUserInfoHeaderView.h"
#import "GUVRepositoryTableViewCell.h"
#import "GUVUserProfileViewController.h"
#import "GUVAPIClient.h"
#import "GUVRepository.h"
#import "GUVRepositoryDetailViewController.h"

static const CGFloat IconSize = 20;

@interface GUVRepositoriesViewController ()

@property (weak, nonatomic) IBOutlet GUVUserInfoHeaderView *userInfoHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *errorMassageWrapperView;
@property (weak, nonatomic) IBOutlet UILabel *errorMessageLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *inquiryViewControllerAppearButton;
@property (nonatomic, weak) id<GUVUserProvider> provider;
@property (nonatomic, nonnull) NSArray<GUVRepository *> *repositories;

@end

@implementation GUVRepositoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSAssert([self.tabBarController isKindOfClass:[GUVUserInfoTabBarController class]], @"tabBarController is of class %@, not of the expected class GUVUserInfoTabBarController", [self.tabBarController class]);
    self.provider = (GUVUserInfoTabBarController *)self.tabBarController;
    FAKFontAwesome *activitiesIcon = [FAKFontAwesome userIconWithSize:IconSize];
    self.inquiryViewControllerAppearButton.image = [activitiesIcon imageWithSize:CGSizeMake(IconSize, IconSize)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSAssert([self.tabBarController isKindOfClass:[GUVUserInfoTabBarController class]], @"tabBarController is of class %@, not of the expected class GUVUserInfoTabBarController", [self.tabBarController class]);
    self.provider = (GUVUserInfoTabBarController *)self.tabBarController;
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
    if ([segue.identifier isEqual: @"jumpToUserProfileVC"]) {
        GUVUserProfileViewController *userProfileViewController = segue.destinationViewController;
        userProfileViewController.provider = self.provider;
    } else {
        if ([sender isKindOfClass:[GUVRepositoryTableViewCell class]]) {
            GUVRepositoryTableViewCell *repositoryTableCell = sender;
            GUVRepositoryDetailViewController *repositoryDetailViewController = segue.destinationViewController;
            repositoryDetailViewController.repository = repositoryTableCell.repository;
        }
    }
}

- (IBAction)didTapInquiryViewControllerAppearButton:(UIBarButtonItem *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GUVInquiryViewController *inquiryViewController = [storyboard instantiateViewControllerWithIdentifier:@"GUVInquiryViewController"];

    NSAssert([self.tabBarController isKindOfClass:[GUVUserInfoTabBarController class]], @"tabBarController is of class %@, not of the expected class GUVUserInfoTabBarController", [self.tabBarController class]);
    GUVUserInfoTabBarController *tabBarController = (GUVUserInfoTabBarController *)self.tabBarController;
    inquiryViewController.delegate = tabBarController;

    [self presentViewController:inquiryViewController animated:YES completion:nil];
}

- (void)setProvider:(id<GUVUserProvider>)provider {
    _provider = provider;

    self.userInfoHeaderView.user = self.provider.fetchedUser;

    GUVAPIClient *client = [GUVAPIClient sharedClient];
    [client requestRepositoriesInfo:self.provider.fetchedUser.name completionBlock:^(NSArray<GUVRepository *> * _Nonnull repositories, NSError * _Nullable error) {
        if (repositories.count != 0) {
            [self showTableView];
            self.repositories = repositories;
            [self.tableView reloadData];
        } else {
            [self showErrorMessageViewWithMessage:nil];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repositories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GUVRepositoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepositoryCell" forIndexPath:indexPath];
    cell.repository = self.repositories[indexPath.item];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Repositories";
}

@end
