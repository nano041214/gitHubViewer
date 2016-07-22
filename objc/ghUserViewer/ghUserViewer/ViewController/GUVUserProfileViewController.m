#import "GUVUserProfileViewController.h"

@interface GUVUserProfileViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray<NSString *> *userProfileArray;
@property (nonatomic) NSArray<NSString *> *userProfileTitleArray;

@end

@implementation GUVUserProfileViewController

- (void)setUser:(GUVUser *)user {
    _user = user;
    self.userProfileTitleArray = @[@"Email", @"Blog", @"Location", @"Joined at"];

    // TODO: add user method inserting '-' if one of its properties is <null> and return userProfileArray
    // self.userProfileArray = @[self.user.blogURL, self.user.mailAddress, self.user.location, self.user.joinedDate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.user);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userProfileTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCell" forIndexPath:indexPath];
    cell.textLabel.text = self.userProfileTitleArray[indexPath.item];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Profile";
}

@end
