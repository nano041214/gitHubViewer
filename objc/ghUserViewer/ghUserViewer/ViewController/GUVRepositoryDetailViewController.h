#import <UIKit/UIKit.h>
#import "GUVRepository.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GUVBrowserOpener <NSObject>

- (void)jumpToGithubRepository:(NSURL *)repositoryURL;

@end

@interface GUVRepositoryDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, GUVBrowserOpener>

@property (nonatomic) GUVRepository *repository;

@end

NS_ASSUME_NONNULL_END
