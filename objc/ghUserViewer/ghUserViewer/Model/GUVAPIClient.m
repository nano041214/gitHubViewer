#import "GUVAPIClient.h"
#import "GUVUser.h"
#import <Mantle/Mantle.h>

@implementation GUVAPIClient

static NSString * const GHAPIBaseURLString = @"https://api.github.com/users/nano041214";

+ (GUVAPIClient *)sharedGHAPIClient {
    static GUVAPIClient *_sharedWeatherHTTPClient = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedWeatherHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:GHAPIBaseURLString]];
    });

    return _sharedWeatherHTTPClient;
}

- (void)requestUserInfo:(NSString *)userName successBlock:(void (^) (GUVUser *user, NSError *error))success failureBlock:(void (^) (NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:GHAPIBaseURLString];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
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
