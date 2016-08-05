#import "GUVRepositoryTableViewCell.h"
#import "GUVRepository.h"

@interface GUVRepositoryTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *repositoryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *starCountLabel;

@end

@implementation GUVRepositoryTableViewCell

- (void)setRepository:(GUVRepository *)repository {
    _repository = repository;
    self.repositoryNameLabel.text = repository.name;
    self.starCountLabel.text = [@(repository.starredCount) stringValue];
}

@end
