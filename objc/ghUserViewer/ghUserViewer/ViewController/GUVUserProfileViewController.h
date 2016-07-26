#import <UIKit/UIKit.h>
#import "GUVUserInfoTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GUVUserProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<GUVUserProvider> provider;

@end

NS_ASSUME_NONNULL_END
