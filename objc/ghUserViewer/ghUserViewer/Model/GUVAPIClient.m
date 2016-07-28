#import <Mantle/Mantle.h>
#import <AFNetworking.h>
#import "GUVAPIClient.h"
#import "GUVUser.h"

@implementation GUVAPIClient

static NSString * const GHAPIBaseURLString = @"https://api.github.com";

+ (GUVAPIClient *)sharedGHAPIClient {
    static GUVAPIClient *client = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] initWithBaseURL:[NSURL URLWithString:GHAPIBaseURLString]];
    });

    return client;
}

- (void)requestUserInfo:(NSString *)userName successBlock:(void (^) (GUVUser *user, NSError *error))success failureBlock:(void (^) (NSError *error))failure {
    NSString *userInfoInquiryPath = [NSString stringWithFormat:@"/users/%@", userName];
    [self GET:userInfoInquiryPath parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        if (success) {
            GUVUser *user = [MTLJSONAdapter modelOfClass:GUVUser.class fromJSONDictionary:responseDictionary error:nil];
            success(user, nil);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if(failure){
            failure(error);
        }
    }];
}

@end
