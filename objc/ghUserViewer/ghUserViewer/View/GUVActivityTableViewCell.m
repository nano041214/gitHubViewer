#import "GUVActivityTableViewCell.h"
#import "GUVActivity.h"

@interface GUVActivityTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation GUVActivityTableViewCell

- (void)setActivity:(GUVActivity *)activity {
    _activity = activity;
    self.nameLabel.text = self.activity.name;
    self.descriptionLabel.text = @"Add hogehoge method";
}

@end
