#import <AFNetworking.h>
#import <Foundation/Foundation.h>
#import "GUVActivity.h"
#import "GUVUser.h"
#import "GUVRepository.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const GUVAPIClientErrorDomain;
typedef NS_ENUM(NSInteger, GUVAPIClientErrorCode) {
    GUVAPIClientErrorCodeNotFound,
};

typedef void (^GUVGetUserSuccessBlock)(GUVUser *user);
typedef void (^GUVGetRepositoryCompletionBlock)(NSArray<GUVRepository *> *_Nullable repositories, NSError *_Nullable error);
typedef void (^GUVGetActivitiesCompletionBlock)(NSArray<GUVActivity *> *_Nullable activities, NSError *_Nullable error);

@interface GUVAPIClient : NSObject

+ (GUVAPIClient *)sharedClient;
- (void)requestUserInfo:(NSString *)userName successBlock:(nonnull GUVGetUserSuccessBlock)success failureBlock:(void (^)(NSError *_Nonnull error))failure;
- (void)requestRepositoriesInfo:(NSString *)userName completionBlock:(nonnull GUVGetRepositoryCompletionBlock)completion;
- (void)requestActivitiesInfo:(NSString *)userName completionBlock:(nonnull GUVGetActivitiesCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END