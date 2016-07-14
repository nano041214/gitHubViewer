#import <UIKit/UIKit.h>
#import "GUVUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface GUVRepositoriesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, nullable) GUVUser *user;

@end

NS_ASSUME_NONNULL_END
