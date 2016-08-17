#import "GUVUserProfileViewController.h"
#import "GUVUserInfoHeaderView.h"
#import "GUVUser.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GUVUserProfileTableContent) {
    GUVUserProfileTableContentEmail,
    GUVUserProfileTableContentBlogURL,
    GUVUserProfileTableContentLocation,
    GUVUserProfileTableContentJoinedAt,
    NumberOfGUVUserProfileTableContents,
};

@interface GUVUserProfileViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet GUVUserInfoHeaderView *userInfoHeaderView;
@property (nonatomic, readonly) GUVUser *user;

@end

NS_ASSUME_NONNULL_END

@implementation GUVUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInfoHeaderView.user = self.user;
    self.navigationItem.title = self.user.name;
}

- (void)setProvider:(id<GUVUserProvider>)provider {
    _user = provider.fetchedUser;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return NumberOfGUVUserProfileTableContents;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCell" forIndexPath:indexPath];
    cell.textLabel.text = [self titleStringAtIndexPath:indexPath];
    cell.detailTextLabel.text = [self descriptionStringAtIndexPath:indexPath];
    return cell;
}

- (NSString *)titleStringAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    switch (row) {
        case GUVUserProfileTableContentEmail: {
            return @"Email";
        }
        case GUVUserProfileTableContentBlogURL: {
            return @"Blog URL";
        }
        case GUVUserProfileTableContentLocation: {
            return @"Location";
        }
        case GUVUserProfileTableContentJoinedAt: {
            return @"Joined at";
        }
        default:
            return @"Additional information";
    }
}

- (NSString *)descriptionStringAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    switch (row) {
        case GUVUserProfileTableContentEmail:
            if (self.user.mailAddress != nil) {
                return self.user.mailAddress;
            } else {
                return @"private";
            }
        case GUVUserProfileTableContentBlogURL:
            if (self.user.blogURL != nil) {
                return [NSString stringWithFormat:@"%@", self.user.blogURL];
            } else {
                return @"-";
            }
        case GUVUserProfileTableContentLocation:
            if (self.user.location != nil) {
                return self.user.location;
            } else {
                return @"-";
            }
        case GUVUserProfileTableContentJoinedAt:
            return [NSString stringWithFormat:@"%@", self.user.joinedDate];
        default:
            return @"Additional information";
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Profile";
}



@end
