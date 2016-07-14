#import "GUVRepositoriesViewController.h"
#import "GUVUserInfoTabBarController.h"
#import "GUVUserInfoHeaderView.h"
#import "GUVRepository.h"
#import "GUVRepositoryTableViewCell.h"

@interface GUVRepositoriesViewController ()

@property (weak, nonatomic) IBOutlet GUVUserInfoHeaderView *userInfoHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray<GUVRepository *> *repositories;

@end

@implementation GUVRepositoriesViewController
@synthesize user;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    GUVRepository *repository = [GUVRepository new];
    repository.name = @"hoge gem";
    self.repositories = @[repository];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInfoHeaderView.user = self.user;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)_ {
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
