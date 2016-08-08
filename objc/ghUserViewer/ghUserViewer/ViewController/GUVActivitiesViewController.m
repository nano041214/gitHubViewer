#import "GUVActivitiesViewController.h"
#import "GUVActivity.h"
#import "GUVActivityTableViewCell.h"
#import "GUVAPIClient.h"
#import "GUVUserInfoHeaderView.h"
#import "GUVUserProfileViewController.h"
#import "GUVUserInfoTabBarController.h"

@interface GUVActivitiesViewController ()

@property (weak, nonatomic) IBOutlet GUVUserInfoHeaderView *userInfoHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray<GUVActivity *> *activities;
@property (nonatomic, weak) id<GUVUserProvider> provider;

@end

@implementation GUVActivitiesViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    GUVAPIClient *client = [GUVAPIClient sharedClient];
    [client requestActivitiesInfo:self.provider.fetchUser.name completionBlock:^(NSArray<GUVActivity *> * _Nullable activities, NSError * _Nullable error) {
        if (error != nil) {
            // TODO: Make error hundling
            NSLog(@"%@", error);
        } else {
            self.activities = activities;
            [self.tableView reloadData];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.provider = (id<GUVUserProvider>)self.parentViewController;
    self.userInfoHeaderView.user = self.provider.fetchUser;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GUVUserProfileViewController *userProfileViewController = segue.destinationViewController;
    userProfileViewController.provider = self.provider;
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
