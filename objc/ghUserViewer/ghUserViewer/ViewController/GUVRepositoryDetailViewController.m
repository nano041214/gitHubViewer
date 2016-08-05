#import "GUVRepositoryDetailViewController.h"
#import "GUVGithubLinkView.h"

static const CGFloat TableFooterHeight = 65.0;

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
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

NS_ASSUME_NONNULL_END

@implementation GUVRepositoryDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.titleLabel.text = [NSString stringWithFormat:
                            @"%@/\n%@",
                            self.repository.ownerName,
                            self.repository.name];
    self.descriptionLabel.text = self.repository.descriptionString;
    self.dateLabel.text = [NSString stringWithFormat:
                           @"created at %@    updated at %@",
                           self.repository.createdDate,
                           self.repository.updatedDate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"GUVGithubLinkView" bundle:nil]
     forHeaderFooterViewReuseIdentifier:NSStringFromClass([GUVGithubLinkView class])];
}

- (NSString *)titleForDetailTableContent:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    switch (row) {
        case GUVRepositoryDetailTableContentLanguage:
            return @"Language";
        case GUVRepositoryDetailTableContentStarred:
            return @"Starred";
        case GUVRepositoryDetailTableContentWatcher:
            return @"Watchers";
        case GUVRepositoryDetailTableContentContributer:
            return @"Contributers";
        case GUVRepositoryDetailTableContentCommits:
            return @"Commits";
        case GUVRepositoryDetailTableContentIssue:
            return @"Issues";
        case GUVRepositoryDetailTableContentBranch:
            return @"Branches";
        default:
            return @"Additional information";
    }
}


- (NSString *)descriptionForDetailTableContent:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    switch (row) {
        case GUVRepositoryDetailTableContentLanguage:
            return self.repository.language;
        case GUVRepositoryDetailTableContentStarred:
            return [NSString stringWithFormat:@"%ld stars", self.repository.starredCount];
        case GUVRepositoryDetailTableContentWatcher:
            return [NSString stringWithFormat:@"%ld watchers", self.repository.watcherCount];
        case GUVRepositoryDetailTableContentContributer:
            return @"Contributers";
        case GUVRepositoryDetailTableContentCommits:
            return @"Commits";
        case GUVRepositoryDetailTableContentIssue:
            return [NSString stringWithFormat:@"%ld issues", self.repository.issueCount];
        case GUVRepositoryDetailTableContentBranch:
            return @"Branches";
        default:
            return @"Additional information";
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return NumberOfGUVRepositoryDetailTableContents;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepositoryDetailCell" forIndexPath:indexPath];
    cell.textLabel.text = [self titleForDetailTableContent:indexPath];
    cell.detailTextLabel.text = [self descriptionForDetailTableContent:indexPath];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Activities";
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([GUVGithubLinkView class])];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return TableFooterHeight;
}

@end
