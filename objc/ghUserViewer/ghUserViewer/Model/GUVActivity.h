#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface GUVActivity : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *repositoryName;

@end

NS_ASSUME_NONNULL_END
