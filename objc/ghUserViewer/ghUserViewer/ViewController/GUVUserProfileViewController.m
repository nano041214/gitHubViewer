#import "GUVUserProfileViewController.h"
#import "GUVUserInfoHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GUVUserProfileTableContent) {
    GUVUserProfileTableContentEmail,
    GUVUserProfileTableContentBlogURL,
    GUVUserProfileTableContentLocation,
    GUVUserProfileTableContentJoinedAt,
};

@interface GUVUserProfileViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet GUVUserInfoHeaderView *userInfoHeaderView;

@end

NS_ASSUME_NONNULL_END

@implementation GUVUserProfileViewController

- (void)setUser:(GUVUser *)user {
    _user = user;

//    self.userProfileTitleArray = @[@"Email", @"Blog", @"Location", @"Joined at"];
    // TODO: add user method inserting '-' if one of its properties is <null> and return userProfileArray
    // self.userProfileArray = @[self.user.blogURL, self.user.mailAddress, self.user.location, self.user.joinedDate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInfoHeaderView.user = self.user;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCell" forIndexPath:indexPath];
    NSInteger contentIndex = indexPath.item;
    switch (contentIndex) {
        case GUVUserProfileTableContentEmail: {
            cell.textLabel.text = @"Email address";
            return cell;
        }
        case GUVUserProfileTableContentBlogURL: {
            cell.textLabel.text = @"Blog URL";
            return cell;
        }
        case GUVUserProfileTableContentLocation: {
            cell.textLabel.text = @"Location";
            return cell;
        }
        case GUVUserProfileTableContentJoinedAt: {
            cell.textLabel.text = @"Joined at";
            return cell;
        }
        default:
            return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Profile";
}



@end
