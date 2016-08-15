#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface GUVUser : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSURL *iconURL;
@property (nonatomic, readonly) NSUInteger followersCount;
@property (nonatomic, readonly) NSUInteger followingCount;
@property (nonatomic, readonly) NSUInteger starredCount;
@property (nonatomic, readonly, nullable) NSURL *blogURL;
@property (nonatomic, readonly, nullable) NSString *mailAddress;
@property (nonatomic, readonly, nullable) NSString *location;
@property (nonatomic, readonly) NSDate *joinedDate;

NS_ASSUME_NONNULL_END

@end
