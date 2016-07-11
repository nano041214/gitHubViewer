#import "GUVRepositoriesViewController.h"
#import "GUVUserInfoTabBarController.h"
#import "GUVUserInfoHeaderView.h"

@interface GUVRepositoriesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet GUVUserInfoHeaderView *userInfoHeaderView;

@end

@implementation GUVRepositoriesViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self.userInfoHeaderView updateConstraints];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepositoryCell" forIndexPath:indexPath];
    GUVUserInfoTabBarController *userInfoTabBarController = (GUVUserInfoTabBarController *)self.tabBarController;
    cell.textLabel.text = userInfoTabBarController.user.name;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Repositories";
}

@end
