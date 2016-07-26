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
}

- (void)setProvider:(id<GUVUserProvider>)provider {
    _user = provider.fetchUser;
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
    NSInteger contentIndex = indexPath.row;
    cell.textLabel.text = [self titleForProfileTableContent:contentIndex];
    return cell;
}

- (NSString *)titleForProfileTableContent:(GUVUserProfileTableContent)profileTableContent{
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
