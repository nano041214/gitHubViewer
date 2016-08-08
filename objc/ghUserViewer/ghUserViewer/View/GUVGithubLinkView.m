#import "GUVGithubLinkView.h"

@implementation GUVGithubLinkView

- (IBAction)didTapLinkButton:(id)sender {
    [[UIApplication sharedApplication] openURL:self.githubURL];
}

@end
