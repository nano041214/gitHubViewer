#import "GUVRepositoryDetailViewController.h"
#import "GUVGithubLinkView.h"

NS_ASSUME_NONNULL_BEGIN

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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepositoryDetailCell" forIndexPath:indexPath];
    cell.textLabel.text = @"hoge";
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Activities";
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    _linkView = [GUVGithubLinkView new];
    return self.linkView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 65;
}

@end
