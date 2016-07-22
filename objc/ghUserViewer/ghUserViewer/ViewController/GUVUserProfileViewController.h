#import <UIKit/UIKit.h>
#import "GUVUser.h"

@interface GUVUserProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, nullable) GUVUser *user;

@end
