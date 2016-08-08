#import "GUVUserInfoHeaderView.h"
#import "GUVRepositoriesViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GUVUserInfoHeaderView ()

@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *userIconImageView;
@property (nonatomic, weak) IBOutlet UILabel *followingCountLabel;
@property (nonatomic, weak) IBOutlet UILabel *followersCountLabel;
@property (nonatomic, weak) IBOutlet UILabel *starredCountLabel;

@end

@implementation GUVUserInfoHeaderView

- (void)setUser:(GUVUser *)user {
    _user = user;
    self.userNameLabel.text = user.name;
    [self.userIconImageView sd_setImageWithURL:user.iconURL
                              placeholderImage:[UIImage imageNamed:@"octcat"]];
    self.followersCountLabel.text = [@(user.followersCount) stringValue];
    self.followingCountLabel.text = [@(user.followingCount) stringValue];
    self.starredCountLabel.text = [@(user.starredCount) stringValue];
}

@end
