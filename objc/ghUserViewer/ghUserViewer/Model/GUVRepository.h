#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface GUVRepository : MTLModel <MTLJSONSerializing>

// cast without readonly for debug
@property (nonatomic) NSString *ownerName;
@property (nonatomic) NSString *name;
@property (nonatomic, readonly, nullable) NSString *language;
@property (nonatomic, readonly, nullable) NSString *descriptionString;
// Question: followersCount? followerCount? which is more natural?
@property (nonatomic, readonly) NSUInteger followerCount;
@property (nonatomic, readonly) NSUInteger starredCount;
@property (nonatomic, readonly) NSUInteger watcherCount;
@property (nonatomic, readonly) NSUInteger contributerCount;
@property (nonatomic, readonly) NSUInteger commitCount;
@property (nonatomic, readonly) NSUInteger issueCount;
@property (nonatomic, readonly) NSUInteger branchCount;
@property (nonatomic, readonly) NSDate *createdDate;
@property (nonatomic, readonly) NSDate *updatedDate;
@property (nonatomic, readonly) NSURL *repositoryURL;

- (NSString *)formatedRepositoryNameString;
- (NSString *)formatedCreatedAndUpdatedDateString;

@end

NS_ASSUME_NONNULL_END
