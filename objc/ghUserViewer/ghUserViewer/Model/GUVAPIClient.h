#import <Foundation/Foundation.h>
#import "GUVUser.h"
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface GUVAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;
- (void)requestUserInfo:(NSString *)userName successBlock:(void (^)(GUVUser *_Nullable user))success failureBlock:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
