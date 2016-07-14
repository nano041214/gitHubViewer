#import <UIKit/UIKit.h>
#import "GUVUser.h"

@protocol UserProvider <NSObject>

@property (nonatomic) GUVUser *user;

@end

NS_ASSUME_NONNULL_BEGIN

@interface GUVUserInfoTabBarController : UITabBarController <UserProvider>

@end

NS_ASSUME_NONNULL_END
