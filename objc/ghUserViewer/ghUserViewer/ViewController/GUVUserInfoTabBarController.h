#import <UIKit/UIKit.h>
#import "GUVUser.h"

@protocol GUVUserProvider <NSObject>

@property (nonatomic) GUVUser *user;

@end

NS_ASSUME_NONNULL_BEGIN

@interface GUVUserInfoTabBarController : UITabBarController <GUVUserProvider>

@end

NS_ASSUME_NONNULL_END
