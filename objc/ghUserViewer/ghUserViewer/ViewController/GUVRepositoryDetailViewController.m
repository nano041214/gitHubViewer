#import "GUVRepositoryDetailViewController.h"

@interface GUVRepositoryDetailViewController ()

@end

@implementation GUVRepositoryDetailViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 7){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LinkToGitHub" forIndexPath:indexPath];
        cell.textLabel.text = @"ViewOnGH";
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepositoryDetailCell" forIndexPath:indexPath];
        cell.textLabel.text = @"hoge";
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Activities";
}

@end
