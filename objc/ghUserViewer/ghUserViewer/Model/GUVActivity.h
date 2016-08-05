#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface GUVActivity : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *descriptionString;

@end

NS_ASSUME_NONNULL_END
