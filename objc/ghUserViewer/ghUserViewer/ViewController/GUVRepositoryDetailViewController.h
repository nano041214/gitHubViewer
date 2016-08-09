#import <UIKit/UIKit.h>
#import "GUVRepository.h"
#import "GUVGithubLinkView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GUVRepositoryDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, GUVGithubLinkViewDelegate>

@property (nonatomic) GUVRepository *repository;

@end

NS_ASSUME_NONNULL_END
