#import "GUVGithubLinkView.h"

@interface GUVGithubLinkView ()

@property (weak, nonatomic) IBOutlet UILabel *GHLinkLabel;

@end

@implementation GUVGithubLinkView

- (instancetype)init {
    self = [super init];
    if(self){
        UINib *nib = [UINib nibWithNibName:@"GUVGithubLinkView" bundle:nil];
        self = [nib instantiateWithOwner:nil options:nil][0];

        UIView *topBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
        // TODO: define color for this border
        topBorder.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:topBorder];
    }
    return self;
}

- (void)setGithubURL:(NSURL *)githubURL {
}

@end
