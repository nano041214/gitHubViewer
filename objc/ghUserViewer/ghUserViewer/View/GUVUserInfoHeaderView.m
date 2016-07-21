#import "GUVUserInfoHeaderView.h"
#import "GUVRepositoriesViewController.h"

@interface GUVUserInfoHeaderView ()

@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;

@end

@implementation GUVUserInfoHeaderView

- (void)setUser:(GUVUser *)user {
    _user = user;
    self.userNameLabel.text = user.name;
}

@end
