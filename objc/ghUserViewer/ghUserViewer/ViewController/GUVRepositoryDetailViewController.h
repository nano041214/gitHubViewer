#import <UIKit/UIKit.h>
#import "GUVRepository.h"

NS_ASSUME_NONNULL_BEGIN

@interface GUVRepositoryDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) GUVRepository *repository;

@end

NS_ASSUME_NONNULL_END
