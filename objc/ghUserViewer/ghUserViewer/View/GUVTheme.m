#import <ChameleonFramework/Chameleon.h>
#import "GUVTheme.h"

@implementation GUVTheme

+ (void)initializeTheme {
    [GUVTheme initializeTabBarAppearance];
    [GUVTheme initializeNavigationBarAppearance];
    [GUVTheme initializeButtonAppearance];
    [GUVTheme initializeTableAppearance];
    [GUVTheme initializeTextFiledAppearance];
}

+ (void)initializeTabBarAppearance {
    [UITabBar appearance].barTintColor = [UIColor flatMintColor];
    [UITabBar appearance].tintColor = [UIColor flatWhiteColor];
}

+ (void)initializeNavigationBarAppearance {
    [UINavigationBar appearance].barTintColor = [UIColor flatMintColor];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor flatWhiteColor]};
    [UIBarButtonItem appearance].tintColor = [UIColor flatWhiteColor];
    [UINavigationBar appearance].tintColor = [UIColor flatWhiteColor];
}

+ (void)initializeButtonAppearance {
    [[UIButton appearance] setTitleColor:[UIColor flatMintColor] forState:UIControlStateNormal];
}

+ (void)initializeTableAppearance {
    [UITableViewHeaderFooterView appearance].tintColor = [UIColor flatMintColor];
    [UITableViewHeaderFooterView appearance].textLabel.textColor = [UIColor flatWhiteColor];
}

+ (void)initializeTextFiledAppearance {
    [UITextField appearance].tintColor = [UIColor flatMintColor];
}

@end
