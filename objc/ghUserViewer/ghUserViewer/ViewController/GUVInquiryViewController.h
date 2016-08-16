#import <UIKit/UIKit.h>
#import "GUVUser.h"

NS_ASSUME_NONNULL_BEGIN

@class GUVInquiryViewController;

@protocol GUVInquiryViewControllerDelegate <NSObject>

- (void)viewController:(GUVInquiryViewController *)viewController userWasSelected:(GUVUser *)user;

@end

@interface GUVInquiryViewController : UIViewController

@property (nonatomic, weak) id<GUVInquiryViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
