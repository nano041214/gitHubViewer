#import "GUVUserProfileViewController.h"
#import "GUVUserInfoHeaderView.h"
#import "GUVUser.h"

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
@property (nonatomic, readonly) GUVUser *user;

@end

NS_ASSUME_NONNULL_END

@implementation GUVUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _user = self.provider.fetchUser;
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
    cell.textLabel.text = [self convertGUVUserProfileTableContentToTitleString:contentIndex];
    return cell;
}

- (NSString *)convertGUVUserProfileTableContentToTitleString:(GUVUserProfileTableContent)profileTableContent{
    switch (profileTableContent) {
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Profile";
}



@end
