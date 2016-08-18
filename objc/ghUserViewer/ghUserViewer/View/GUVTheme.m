#import <ChameleonFramework/Chameleon.h>
#import "GUVTheme.h"

@implementation GUVTheme

+ (void)setTheme {
    [GUVTheme setTabBarAppearance];
    [GUVTheme setNavigationBarAppearance];
    [GUVTheme setButtonAppearance];
    [GUVTheme setTableAppearance];
    [GUVTheme setTextFiledAppearance];
}

+ (void)setTabBarAppearance {
    [UITabBar appearance].barTintColor = [UIColor flatMintColor];
    [UITabBar appearance].tintColor = [UIColor flatWhiteColor];
}

+ (void)setNavigationBarAppearance {
    [UINavigationBar appearance].barTintColor = [UIColor flatMintColor];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor flatWhiteColor]};
    [UIBarButtonItem appearance].tintColor = [UIColor flatWhiteColor];
    [UINavigationBar appearance].tintColor = [UIColor flatWhiteColor];
}

+ (void)setButtonAppearance {
    [[UIButton appearance] setTitleColor:[UIColor flatMintColor] forState:UIControlStateNormal];
}

+ (void)setTableAppearance {
    [UITableViewHeaderFooterView appearance].tintColor = [UIColor flatMintColor];
    [UITableViewHeaderFooterView appearance].textLabel.textColor = [UIColor flatWhiteColor];
}

+ (void)setTextFiledAppearance {
    [UITextField appearance].tintColor = [UIColor flatMintColor];
}

@end
