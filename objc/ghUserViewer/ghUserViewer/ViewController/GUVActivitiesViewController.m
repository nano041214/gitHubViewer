#import "GUVActivitiesViewController.h"
#import "GUVUserInfoTabBarController.h"
#import "GUVActivityTableViewCell.h"
#import "GUVActivity.h"

@interface GUVActivitiesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray<GUVActivity *> *activities;

@end

@implementation GUVActivitiesViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    GUVActivity *activity = [GUVActivity new];
    activity.name = @"IssueEvent";
    self.activities = @[activity];
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
