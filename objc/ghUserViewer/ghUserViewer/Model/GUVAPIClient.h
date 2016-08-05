#import <AFNetworking.h>
#import <Foundation/Foundation.h>
#import "GUVUser.h"
#import "GUVRepository.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const GUVAPIClientErrorDomain;
typedef NS_ENUM(NSInteger, GUVAPIClientErrorCode) {
    GUVAPIClientErrorCodeNotFound,
};

typedef void (^GUVGetUserSuccessBlock)(GUVUser *user);
typedef void (^GUVGetRepositorySuccessBlock)(NSArray<GUVRepository *> *repositories);

@interface GUVAPIClient : NSObject

+ (GUVAPIClient *)sharedClient;
- (void)requestUserInfo:(NSString *)userName successBlock:(nonnull GUVGetUserSuccessBlock)success failureBlock:(void (^)(NSError *_Nonnull error))failure;
- (void)requestRepositoriesInfo:(NSString *)userName successBlock:(nonnull GUVGetRepositorySuccessBlock)success failureBlock:(void (^)(NSError *_Nonnull error))failure;

@end

NS_ASSUME_NONNULL_END
