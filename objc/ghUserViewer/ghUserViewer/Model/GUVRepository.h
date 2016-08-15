#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface GUVRepository : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) NSString *ownerName;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly, nullable) NSString *language;
@property (nonatomic, readonly, nullable) NSString *descriptionString;
@property (nonatomic, readonly) NSUInteger followersCount;
@property (nonatomic, readonly) NSUInteger starredCount;
@property (nonatomic, readonly) NSUInteger watchersCount;
@property (nonatomic, readonly) NSUInteger contributersCount;
@property (nonatomic, readonly) NSUInteger commitsCount;
@property (nonatomic, readonly) NSUInteger issuesCount;
@property (nonatomic, readonly) NSUInteger branchesCount;
@property (nonatomic, readonly) NSDate *createdDate;
@property (nonatomic, readonly) NSDate *updatedDate;
@property (nonatomic, readonly) NSURL *repositoryURL;

- (NSString *)formattedRepositoryNameString;
- (NSString *)formattedCreatedAndUpdatedDateString;

@end

NS_ASSUME_NONNULL_END
