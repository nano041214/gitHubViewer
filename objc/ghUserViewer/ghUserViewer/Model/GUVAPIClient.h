#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "GUVUser.h"

@interface GUVAPIClient : AFHTTPSessionManager

+ (GUVAPIClient *)sharedGHAPIClient;
- (void)requestUserInfo:(NSString *)userName successBlock:(void (^) (GUVUser *user, NSError *error))success failureBlock:(void (^) (NSError *error))failure;

@end
