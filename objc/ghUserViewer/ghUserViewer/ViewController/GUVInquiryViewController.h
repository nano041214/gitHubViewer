#import <UIKit/UIKit.h>
#import "GUVUser.h"

NS_ASSUME_NONNULL_BEGIN

@class GUVInquiryViewController;

@protocol GUVInquiryViewControllerDelegate <NSObject>

- (void)provideUser:(GUVInquiryViewController *)inquiryViewController user:(GUVUser *)user;

@end

@interface GUVInquiryViewController : UIViewController

@property (nonatomic, weak) id<GUVInquiryViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
