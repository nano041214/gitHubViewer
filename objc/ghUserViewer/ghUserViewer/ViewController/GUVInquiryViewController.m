#import "GUVInquiryViewController.h"
#import "GUVUserInfoTabBarController.h"
#import "GUVUser.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface GUVInquiryViewController ()

@end

@implementation GUVInquiryViewController

- (IBAction)userNameDidEdit:(UITextField *)sender {
    [SVProgressHUD show];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"https://api.github.com/users/%@", sender.text];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        _user = [MTLJSONAdapter modelOfClass:GUVUser.class
                              fromJSONDictionary:responseDictionary error:nil];
        [SVProgressHUD dismiss];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GUVUserInfoTabBarController *usersInfoTabBarController = [storyboard instantiateViewControllerWithIdentifier:@"GUVUsersInfoTabBarController"];
        usersInfoTabBarController.user = self.user;
        [self.navigationController pushViewController:usersInfoTabBarController animated:NO];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
    }];
}

@end
