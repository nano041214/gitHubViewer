#import <Mantle/Mantle.h>
#import <AFNetworking.h>
#import "GUVAPIClient.h"
#import "GUVUser.h"

@implementation GUVAPIClient

static NSString * const GHAPIBaseURLString = @"https://api.github.com";

+ (GUVAPIClient *)sharedClient {
    static GUVAPIClient *client = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] initWithBaseURL:[NSURL URLWithString:GHAPIBaseURLString]];
    });

    return client;
}

- (void)requestUserInfo:(NSString *)userName successBlock:(void (^)(GUVUser *_Nullable user, NSError *_Nullable error))success failureBlock:(void (^)(NSError *error))failure {
    NSString *safeUserName = AFPercentEscapedStringFromString(userName);
    NSString *userInfoInquiryPath = [NSString stringWithFormat:@"/users/%@", safeUserName];
    [self GET:userInfoInquiryPath parameters:nil progress:nil success:^(NSURLSessionTask *task, NSDictionary * responseDictionary) {
        if (success != nil) {
            NSError *mantleError = nil;
            GUVUser *user = [MTLJSONAdapter modelOfClass:GUVUser.class fromJSONDictionary:responseDictionary error:&mantleError];
            success(user, mantleError);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if(failure != nil){
            failure(error);
        }
    }];
}

@end
