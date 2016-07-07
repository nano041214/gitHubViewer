#import <Mantle/Mantle.h>

@interface GUVUser : MTLModel

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSURL *iconUrl;
@property (nonatomic, readonly) NSUInteger followers;
@property (nonatomic, readonly) NSUInteger following;
@property (nonatomic, readonly) NSUInteger starred;
@property (nonatomic, readonly) NSURL *blogUrl;
@property (nonatomic, readonly) NSString *mailAddress;
@property (nonatomic, readonly) NSString *location;
@property (nonatomic, readonly) NSData *joinedAt;

@end
