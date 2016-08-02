#import "GUVGithubLinkView.h"

@implementation GUVGithubLinkView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self != nil){
        UINib *nib = [UINib nibWithNibName:@"GUVGithubLinkView" bundle:nil];
        self = [nib instantiateWithOwner:nil options:nil][0];
    }
    return self;
}

@end
