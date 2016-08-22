#import <ChameleonFramework/Chameleon.h>
#import "GUVTheme.h"

@implementation GUVTheme

+ (void)setupTheme {
    [GUVTheme setupTabBarAppearance];
    [GUVTheme setupNavigationBarAppearance];
    [GUVTheme setupButtonAppearance];
    [GUVTheme setupTableAppearance];
    [GUVTheme setupTextFiledAppearance];
}

+ (void)setupTabBarAppearance {
    [UITabBar appearance].barTintColor = [UIColor flatMintColor];
    [UITabBar appearance].tintColor = [UIColor flatWhiteColor];
}

+ (void)setupNavigationBarAppearance {
    [UINavigationBar appearance].barTintColor = [UIColor flatMintColor];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor flatWhiteColor]};
    [UIBarButtonItem appearance].tintColor = [UIColor flatWhiteColor];
    [UINavigationBar appearance].tintColor = [UIColor flatWhiteColor];
}

+ (void)setupButtonAppearance {
    [[UIButton appearance] setTitleColor:[UIColor flatMintColor] forState:UIControlStateNormal];
}

+ (void)setupTableAppearance {
    [UITableViewHeaderFooterView appearance].tintColor = [UIColor flatMintColor];
    [UITableViewHeaderFooterView appearance].textLabel.textColor = [UIColor flatWhiteColor];
    NSArray *textColorWhiteClassArray = @[[UITableViewHeaderFooterView class]];
    [[UILabel appearanceWhenContainedInInstancesOfClasses:textColorWhiteClassArray] setTextColor:[UIColor flatWhiteColor]];
}

+ (void)setupTextFiledAppearance {
    [UITextField appearance].tintColor = [UIColor flatMintColor];
}

@end
