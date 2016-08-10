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
@property (weak, nonatomic) IBOutlet UIView *massageWrapperView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) id<GUVUserProvider> provider;
@property (nonatomic, nonnull) NSArray<GUVRepository *> *repositories;

@end

@implementation GUVRepositoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.provider = (id<GUVUserProvider>)self.parentViewController;
    self.userInfoHeaderView.user = self.provider.fetchUser;

    GUVAPIClient *client = [GUVAPIClient sharedClient];
    [client requestRepositoriesInfo:self.provider.fetchUser.name completionBlock:^(NSArray<GUVRepository *> * _Nonnull repositories, NSError * _Nullable error) {
        if (error != nil) {
            [self showMessageView];
            self.messageLabel.text = error.localizedDescription;
        } else {
            if (repositories.count != 0) {
                [self showTableView];
                self.repositories = repositories;
                [self.tableView reloadData];
            } else {
                [self showMessageView];
            }
        }
    }];
}

- (void)showTableView {
    self.tableView.hidden = NO;
    self.massageWrapperView.hidden = YES;
}

- (void)showMessageView {
    self.tableView.hidden = YES;
    self.massageWrapperView.hidden = NO;
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
