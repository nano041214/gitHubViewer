#import <UIKit/UIKit.h>
#import "GUVUser.h"
#import "GUVInquiryViewController.h"

@class GUVUserInfoTabBarController;

NS_ASSUME_NONNULL_BEGIN

@protocol GUVUserProvider <NSObject>

- (GUVUser *)fetchUser;

@end

@protocol GUVUserObserver <NSObject>

- (void)userDidUpdated:(GUVUserInfoTabBarController *)userInfoTabBarController;

@end

NS_ASSUME_NONNULL_END

@interface GUVUserInfoTabBarController : UITabBarController <GUVUserProvider, GUVInquiryViewControllerDelegate>

@property (nonatomic, nullable) GUVUser *user;

@end
