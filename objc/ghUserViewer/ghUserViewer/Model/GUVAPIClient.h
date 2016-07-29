#import <Foundation/Foundation.h>
#import "GUVUser.h"
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface GUVAPIClient : AFHTTPSessionManager

+ (GUVAPIClient *)sharedClient;
- (void)requestUserInfo:(NSString *)userName successBlock:(void (^)(GUVUser *_Nullable user, NSError *_Nullable error))success failureBlock:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
