#import <UIKit/UIKit.h>
#import "GUVUser.h"

@protocol GUVUserProvider <NSObject>

@property (nonatomic) GUVUser *user;

@end

@interface GUVUserInfoTabBarController : UITabBarController <GUVUserProvider>

@end
