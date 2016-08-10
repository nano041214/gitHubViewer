#import <Mantle/Mantle.h>
#import "GUVAPIClient.h"

NS_ASSUME_NONNULL_BEGIN

NSString *const GUVAPIClientErrorDomain = @"com.cookpad.ghUserViewer.api.client.error";

@interface GUVAPIClient ()

@property (nonatomic) AFHTTPSessionManager *httpManager;

@end

NS_ASSUME_NONNULL_END

@implementation GUVAPIClient

static NSString * const GitHubAPIBaseURLString = @"https://api.github.com";

- (instancetype)init {
    self = [super init];
    self.httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:GitHubAPIBaseURLString]];
    return self;
}

+ (GUVAPIClient *)sharedClient {
    static GUVAPIClient *client = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [GUVAPIClient new];
    });
    return client;
}

- (void)requestUserInfo:(NSString *)userName successBlock:(nonnull GUVGetUserSuccessBlock)success failureBlock:(void (^)(NSError *_Nonnull error))failure {
    NSString *safeUserName = AFPercentEscapedStringFromString(userName);
    NSString *userInfoInquiryPath = [NSString stringWithFormat:@"/users/%@", safeUserName];

    [self.httpManager GET:userInfoInquiryPath parameters:nil progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseDictionary) {
        NSError *mantleError = nil;
        GUVUser *user = [MTLJSONAdapter modelOfClass:[GUVUser class] fromJSONDictionary:responseDictionary error:&mantleError];
        if (mantleError != nil) {
            failure(mantleError);
        } else {
            success(user);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if ([operation.response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) operation.response;
            if (httpResponse.statusCode == 404) {
                error = [GUVAPIClient noSuchUserError];
            }
        }
        failure(error);
    }];
}

- (void)requestRepositoriesInfo:(NSString *)userName completionBlock:(nonnull GUVGetRepositoryCompletionBlock)completion {
    NSString *safeUserName = AFPercentEscapedStringFromString(userName);
    NSString *userInfoInquiryPath = [NSString stringWithFormat:@"/users/%@/repos", safeUserName];

    [self.httpManager GET:userInfoInquiryPath parameters:nil progress:nil success:^(NSURLSessionTask *task, NSArray * responseArray) {
        NSError *mantleError = nil;
        NSArray<GUVRepository*> *repositories = [MTLJSONAdapter modelsOfClass:[GUVRepository class] fromJSONArray:responseArray error:&mantleError];
        if (mantleError != nil) {
            completion(nil, mantleError);
        } else {
            completion(repositories, nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void)requestActivitiesInfo:(NSString *)userName completionBlock:(nonnull GUVGetActivitiesCompletionBlock)completion {
    NSString *safeUserName = AFPercentEscapedStringFromString(userName);
    NSString *userInfoInquiryPath = [NSString stringWithFormat:@"/users/%@/events", safeUserName];

    [self.httpManager GET:userInfoInquiryPath parameters:nil progress:nil success:^(NSURLSessionTask *task, NSArray * responseArray) {
        NSError *mantleError = nil;
        NSArray<GUVActivity *> *activities = [MTLJSONAdapter modelsOfClass:[GUVActivity class] fromJSONArray:responseArray error:&mantleError];
        if (mantleError != nil) {
            completion(nil, mantleError);
        } else {
            completion(activities, nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        completion(nil, error);
    }];
}

+ (NSError *)noSuchUserError {
    NSDictionary *errorUserInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"NoSuchUserHere", nil),
                                    NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"PleaseEnterCorrectUserName", nil)};
    return [[NSError alloc] initWithDomain:GUVAPIClientErrorDomain code:GUVAPIClientErrorCodeNotFound userInfo:errorUserInfo];
}

@end
