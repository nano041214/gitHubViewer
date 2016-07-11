#import "GUVUserInfoHeaderView.h"
#import "GUVRepositoriesViewController.h"

@interface GUVUserInfoHeaderView()

@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *followersLabel;
@property (nonatomic, weak) IBOutlet UILabel *starredLabel;
@property (nonatomic, weak) IBOutlet UILabel *followingLabel;

@end

@implementation GUVUserInfoHeaderView

- (void)setUserNameLabel:(UILabel *)userNameLabel {
    // get user from ReposVC...
    userNameLabel.text = @"hoge";
}

- (void)setFollowersLabel:(UILabel *)followersLabel {
    followersLabel.text = [NSString stringWithFormat:@"%d", 32];
}

- (void)setStarredLabel:(UILabel *)starredLabel {
    starredLabel.text = [NSString stringWithFormat:@"%d", 43];
}

- (void)setFollowingLabel:(UILabel *)followingLabel {
    followingLabel.text = [NSString stringWithFormat:@"%d", 93];;
}

@end
