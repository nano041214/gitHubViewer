#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface GUVRepository : MTLModel

// cast without readonly for debug
@property (nonatomic) NSString *name;
@property (nonatomic, readonly, nullable) NSString *language;
@property (nonatomic, readonly, nullable) NSString *repositoryDescription;
@property (nonatomic, readonly) NSUInteger following;
@property (nonatomic, readonly) NSUInteger starredNum;
@property (nonatomic, readonly) NSUInteger watcherNum;
@property (nonatomic, readonly) NSUInteger contributerNum;
@property (nonatomic, readonly) NSUInteger commitNum;
@property (nonatomic, readonly) NSUInteger issueNum;
@property (nonatomic, readonly) NSUInteger branchNum;
@property (nonatomic, readonly) NSDate *createdAt;
@property (nonatomic, readonly) NSDate *updatedAt;
@property (nonatomic, readonly) NSURL *repositoryURL;

@end

NS_ASSUME_NONNULL_END
