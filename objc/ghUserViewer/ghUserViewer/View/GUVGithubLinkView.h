#import <UIKit/UIKit.h>
#import "GUVRepositoryDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GUVGithubLinkView : UITableViewHeaderFooterView

@property (nonatomic) NSURL *repositoryURL;
@property (nonatomic, weak) id<GUVBrowserOpener> opener;

@end

NS_ASSUME_NONNULL_END
