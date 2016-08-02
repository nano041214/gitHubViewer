#import "GUVGithubLinkView.h"

@implementation GUVGithubLinkView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self != nil){
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"GUVGithubLinkView" owner:self options:nil];
        GUVGithubLinkView *linkView = subviewArray[0];
        [linkView setFrame:self.bounds];
        [self addSubview:linkView];
    }
    return self;
}

@end
