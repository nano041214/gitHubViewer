#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface GUVRepository : MTLModel <MTLJSONSerializing>

// cast without readonly for debug
@property (nonatomic) NSString *name;
@property (nonatomic, readonly, nullable) NSString *language;
@property (nonatomic, readonly, nullable) NSString *descriptionString;
@property (nonatomic, readonly) NSUInteger followingCount;
@property (nonatomic, readonly) NSUInteger starredCount;
@property (nonatomic, readonly) NSUInteger watcherCount;
@property (nonatomic, readonly) NSUInteger contributerCount;
@property (nonatomic, readonly) NSUInteger commitCount;
@property (nonatomic, readonly) NSUInteger issueCount;
@property (nonatomic, readonly) NSUInteger branchCount;
@property (nonatomic, readonly) NSDate *createdAt;
@property (nonatomic, readonly) NSDate *updatedAt;
@property (nonatomic, readonly) NSURL *repositoryURL;

@end

NS_ASSUME_NONNULL_END
