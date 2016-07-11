#import "GUVUserInfoHeaderView.h"
#import <PureLayout/PureLayout.h>

@interface GUVUserInfoHeaderView ()

@property (nonatomic, weak) IBOutlet UIImageView *userIconView;
@end

@implementation GUVUserInfoHeaderView

- (void)updateConstraints {
    [self.userIconView autoSetDimensionsToSize:CGSizeMake(self.userIconView.frame.size.width, self.userIconView.frame.size.width)];
    self.userIconView.layer.cornerRadius = 3.0;
    [super updateConstraints];
}

@end
