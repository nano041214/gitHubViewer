#import <UIKit/UIKit.h>
#import "GUVUserInfoTabBarController.h"

@interface GUVActivitiesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<GUVUserProvider> userProvider;

@end
