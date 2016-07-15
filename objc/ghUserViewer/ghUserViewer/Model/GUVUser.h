#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface GUVUser : MTLModel

// remove readonly workaround
@property (nonatomic) NSString *name;
@property (nonatomic, readonly) NSURL *iconUrl;
@property (nonatomic, readonly) NSUInteger followers;
@property (nonatomic, readonly) NSUInteger following;
@property (nonatomic, readonly) NSUInteger starred;
@property (nonatomic, readonly, nullable) NSURL *blogUrl;
@property (nonatomic, readonly, nullable) NSString *mailAddress;
@property (nonatomic, readonly, nullable) NSString *location;
@property (nonatomic, readonly) NSDate *joinedAt;

NS_ASSUME_NONNULL_END

@end
