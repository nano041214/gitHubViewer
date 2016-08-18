#import <UIKit/UIKit.h>
#import "GUVUser.h"
#import "GUVInquiryViewController.h"

@class GUVUserInfoTabBarController;

NS_ASSUME_NONNULL_BEGIN

@protocol GUVUserProvider <NSObject>

@property (nonatomic, nullable, readonly) GUVUser *user;

@end

NS_ASSUME_NONNULL_END

@interface GUVUserInfoTabBarController : UITabBarController <GUVUserProvider, GUVInquiryViewControllerDelegate>

@end
