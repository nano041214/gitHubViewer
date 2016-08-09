#import "GUVGithubLinkView.h"

@implementation GUVGithubLinkView

- (IBAction)didTapLinkButton:(id)sender {
    [self.delegate didTapLinkButtonOnLinkView:self];
}

@end
