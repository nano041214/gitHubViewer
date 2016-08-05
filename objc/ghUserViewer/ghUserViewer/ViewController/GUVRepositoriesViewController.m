#import "GUVRepositoriesViewController.h"
#import "GUVUserInfoHeaderView.h"
#import "GUVRepository.h"
#import "GUVRepositoryTableViewCell.h"
#import "GUVUserInfoTabBarController.h"
#import "GUVUserProfileViewController.h"
#import "GUVAPIClient.h"

@interface GUVRepositoriesViewController ()

@property (weak, nonatomic) IBOutlet GUVUserInfoHeaderView *userInfoHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray<GUVRepository *> *repositories;
@property (nonatomic, weak) id<GUVUserProvider> provider;

@end

@implementation GUVRepositoriesViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    GUVAPIClient *client = [GUVAPIClient sharedClient];
    [client requestRepositoryInfo:self.provider.fetchUser.name successBlock:^(GUVRepository * _Nonnull repository) {
        self.repositories = @[repository];
        [self.tableView reloadData];
        NSLog(@"success");
    } failureBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.provider = (id<GUVUserProvider>)self.parentViewController;
    self.userInfoHeaderView.user = self.provider.fetchUser;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"jumpToUserProfileVC"]) {
        GUVUserProfileViewController *userProfileViewController = segue.destinationViewController;
        userProfileViewController.provider = self.provider;
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
