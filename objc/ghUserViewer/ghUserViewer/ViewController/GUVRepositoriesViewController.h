#import <UIKit/UIKit.h>
#import "GUVUserInfoTabBarController.h"

@interface GUVRepositoriesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<GUVUserProvider> userProvider;

@end
