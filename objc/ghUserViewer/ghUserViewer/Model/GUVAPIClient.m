#import <Mantle/Mantle.h>
#import "GUVAPIClient.h"
#import "GUVUser.h"

@interface GUVAPIClient ()

@property (nonatomic) AFHTTPSessionManager *httpManager;

@end

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

- (void)requestUserInfo:(NSString *)userName successBlock:(void (^)(GUVUser *user))success failureBlock:(void (^)(NSError *error))failure {
    NSString *safeUserName = AFPercentEscapedStringFromString(userName);
    NSString *userInfoInquiryPath = [NSString stringWithFormat:@"/users/%@", safeUserName];

    [self.httpManager GET:userInfoInquiryPath parameters:nil progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseDictionary) {
        NSError *mantleError = nil;
        GUVUser *user = [MTLJSONAdapter modelOfClass:GUVUser.class fromJSONDictionary:responseDictionary error:&mantleError];
        if (mantleError != nil){
            failure(mantleError);
        }else {
            success(user);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        failure(error);
    }];
}

@end
