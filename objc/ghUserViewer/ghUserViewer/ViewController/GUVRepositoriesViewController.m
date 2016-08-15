#import "GUVRepositoriesViewController.h"
#import "GUVUserInfoHeaderView.h"
#import "GUVRepositoryTableViewCell.h"
#import "GUVUserInfoTabBarController.h"
#import "GUVUserProfileViewController.h"
#import "GUVAPIClient.h"
#import "GUVRepository.h"
#import "GUVRepositoryDetailViewController.h"

@interface GUVRepositoriesViewController ()

@property (weak, nonatomic) IBOutlet GUVUserInfoHeaderView *userInfoHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *errorMassageWrapperView;
@property (weak, nonatomic) IBOutlet UILabel *errorMessageLabel;
@property (nonatomic, weak) id<GUVUserProvider> provider;
@property (nonatomic, nonnull) NSArray<GUVRepository *> *repositories;

@end

@implementation GUVRepositoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.provider = (id<GUVUserProvider>)self.parentViewController.parentViewController;
    self.userInfoHeaderView.user = self.provider.fetchUser;

    GUVAPIClient *client = [GUVAPIClient sharedClient];
    [client requestRepositoriesInfo:self.provider.fetchUser.name completionBlock:^(NSArray<GUVRepository *> * _Nonnull repositories, NSError * _Nullable error) {
        if (repositories.count != 0) {
            [self showTableView];
            self.repositories = repositories;
            [self.tableView reloadData];
        } else {
            [self showErrorMessageViewWithMessage:nil];
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
