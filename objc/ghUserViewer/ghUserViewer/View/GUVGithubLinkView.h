#import <UIKit/UIKit.h>

@class GUVGithubLinkView;

NS_ASSUME_NONNULL_BEGIN

@protocol GUVGithubLinkViewDelegate <NSObject>

- (void)didTapLinkButtonOnLinkView:(GUVGithubLinkView *)linkView;

@end

@interface GUVGithubLinkView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<GUVGithubLinkViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
