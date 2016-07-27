#import <UIKit/UIKit.h>
#import "GUVUser.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GUVUserProvider <NSObject>

-(GUVUser *)fetchUser;

@end

NS_ASSUME_NONNULL_END

@interface GUVUserInfoTabBarController : UITabBarController <GUVUserProvider>

@property (nonatomic, nullable) GUVUser *user;

@end
