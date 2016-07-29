#import "GUVRepositoryDetailViewController.h"
#import "GUVGithubLinkView.h"

static const CGFloat tableFooterHeight = 65.0;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GUVRepositoryDetailTableContent) {
    GUVRepositoryDetailTableContentLanguage,
    GUVRepositoryDetailTableContentStarred,
    GUVRepositoryDetailTableContentWatcher,
    GUVRepositoryDetailTableContentContributer,
    GUVRepositoryDetailTableContentCommits,
    GUVRepositoryDetailTableContentIssue,
    GUVRepositoryDetailTableContentBranch,
    NumberOfGUVRepositoryDetailTableContents,
};


@interface GUVRepositoryDetailViewController ()

@property (nonatomic) GUVGithubLinkView *linkView;

@end

NS_ASSUME_NONNULL_END

@implementation GUVRepositoryDetailViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return NumberOfGUVRepositoryDetailTableContents;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepositoryDetailCell" forIndexPath:indexPath];
    NSInteger contentIndex = indexPath.row;
    cell.textLabel.text = [self titleForDetailTableContent:contentIndex];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Activities";
}

- (NSString *)titleForDetailTableContent:(GUVRepositoryDetailTableContent)detailTableContent{
    switch (detailTableContent) {
        case GUVRepositoryDetailTableContentLanguage: {
            return @"Language";
        }
        case GUVRepositoryDetailTableContentStarred: {
            return @"Starred";
        }
        case GUVRepositoryDetailTableContentWatcher: {
            return @"Watchers";
        }
        case GUVRepositoryDetailTableContentContributer: {
            return @"Contributers";
        }
        case GUVRepositoryDetailTableContentCommits: {
            return @"Commits";
        }
        case GUVRepositoryDetailTableContentIssue: {
            return @"Issues";
        }
        case GUVRepositoryDetailTableContentBranch: {
            return @"Branches";
        }
        default:
            return @"Additional information";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    _linkView = [GUVGithubLinkView new];
    return self.linkView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return tableFooterHeight;
}

@end
