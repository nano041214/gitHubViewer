#import <Foundation/Foundation.h>
#import "GUVUser.h"
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^GUVGetUserSuccessBlock)(GUVUser *user);

@interface GUVAPIClient : NSObject

extern NSString *const GUVAPIClientErrorDomain;
extern const NS_ENUM(NSInteger, GUVAPIClientErrorCode) {
    GUVAPIClientErrorCodeNotFound,
};

+ (GUVAPIClient *)sharedClient;
- (void)requestUserInfo:(NSString *)userName successBlock:(nonnull GUVGetUserSuccessBlock)success failureBlock:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
