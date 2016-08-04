#import <Mantle/Mantle.h>
#import "GUVAPIClient.h"
#import "GUVUser.h"

NS_ASSUME_NONNULL_BEGIN

NSString *const GUVAPIClientErrorDomain = @"com.cookpad.ghUserViewer.api";

@interface GUVAPIClient ()

@property (nonatomic) AFHTTPSessionManager *httpManager;
@property (nonatomic, copy) GUVGetUserSuccessBlock success;

@end

NS_ASSUME_NONNULL_END

@implementation GUVAPIClient

static NSString * const GitHubAPIBaseURLString = @"https://api.github.com";

+ (GUVAPIClient *)sharedClient {
    static GUVAPIClient *client = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [GUVAPIClient new];
        client.httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:GitHubAPIBaseURLString]];
    });
    return client;
}

- (void)requestUserInfo:(NSString *)userName successBlock:(nonnull GUVGetUserSuccessBlock)success failureBlock:(void (^)(NSError *error))failure {
    NSString *safeUserName = AFPercentEscapedStringFromString(userName);
    NSString *userInfoInquiryPath = [NSString stringWithFormat:@"/users/%@", safeUserName];

    [self.httpManager GET:userInfoInquiryPath parameters:nil progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseDictionary) {
        NSError *mantleError = nil;
        GUVUser *user = [MTLJSONAdapter modelOfClass:GUVUser.class fromJSONDictionary:responseDictionary error:&mantleError];
        if (mantleError != nil){
            failure(mantleError);
        } else {
            success(user);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if ([operation.response isKindOfClass:[NSHTTPURLResponse class]])
        {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) operation.response;
            if (httpResponse.statusCode == 404) {
                error = [GUVAPIClient noSuchUserError];
            }
        }
        failure(error);
    }];
}

+ (NSError *)noSuchUserError {
    NSDictionary *errorUserInfo = @{NSLocalizedDescriptionKey: @"No such user here.",
                                    NSLocalizedRecoverySuggestionErrorKey: @"Please enter correct user name"};
    return [[NSError alloc] initWithDomain:GUVAPIClientErrorDomain code:GUVAPIClientErrorCodeNotFound userInfo:errorUserInfo];
}

@end
