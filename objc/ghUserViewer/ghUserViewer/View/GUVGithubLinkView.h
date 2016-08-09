#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GUVGithubLinkViewDelegate <NSObject>

- (void)didTapLinkButton;

@end

@interface GUVGithubLinkView : UITableViewHeaderFooterView

@property (nonatomic) NSURL *repositoryURL;
@property (nonatomic, weak) id<GUVGithubLinkViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
