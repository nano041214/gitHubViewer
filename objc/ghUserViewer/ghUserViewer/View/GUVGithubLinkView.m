#import "GUVGithubLinkView.h"

@implementation GUVGithubLinkView

- (IBAction)didTapLinkButton:(id)sender {
    [self.opener jumpToGithubRepository:self.repositoryURL];
}

@end
