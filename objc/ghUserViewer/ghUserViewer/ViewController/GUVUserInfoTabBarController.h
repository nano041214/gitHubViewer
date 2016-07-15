#import <UIKit/UIKit.h>
#import "GUVUser.h"

@protocol GUVUserProvider <NSObject>

@required
-(nonnull GUVUser *)fetchUser;

@end

@interface GUVUserInfoTabBarController : UITabBarController <GUVUserProvider>

@property (nonatomic, nullable) GUVUser *user;

@end
