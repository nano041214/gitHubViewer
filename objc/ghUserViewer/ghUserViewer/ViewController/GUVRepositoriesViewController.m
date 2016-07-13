#import "GUVRepositoriesViewController.h"
#import "GUVUserInfoTabBarController.h"
#import "GUVUserInfoHeaderView.h"
#import "GUVUser.h"
#import "GUVRepository.h"

@interface GUVRepositoriesViewController ()

@property (weak, nonatomic) IBOutlet GUVUserInfoHeaderView *userInfoHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) GUVUser *user;
@property (nonatomic) NSArray<GUVRepository *> *repositories;

@end

@implementation GUVRepositoriesViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    GUVRepository *repository = [GUVRepository new];
    repository.name = @"hoge gem";
    self.repositories = @[repository];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    GUVUserInfoTabBarController *userInfoTabBarController = (GUVUserInfoTabBarController *)self.tabBarController;
    self.user = userInfoTabBarController.user;
    self.userInfoHeaderView.user = self.user;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repositories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepositoryCell" forIndexPath:indexPath];
    cell.textLabel.text = self.repositories[indexPath.item].name;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Repositories";
}

@end
