#import <ChameleonFramework/Chameleon.h>
#import "GUVTheme.h"

@implementation GUVTheme

+ (void)readyTheme {
    [GUVTheme readyTabBarAppearance];
    [GUVTheme readyNavigationBarAppearance];
    [GUVTheme readyButtonAppearance];
    [GUVTheme readyTableAppearance];
    [GUVTheme readyTextFiledAppearance];
}

+ (void)readyTabBarAppearance {
    [UITabBar appearance].barTintColor = [UIColor flatMintColor];
    [UITabBar appearance].tintColor = [UIColor flatWhiteColor];
}

+ (void)readyNavigationBarAppearance {
    [UINavigationBar appearance].barTintColor = [UIColor flatMintColor];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor flatWhiteColor]};
    [UIBarButtonItem appearance].tintColor = [UIColor flatWhiteColor];
    [UINavigationBar appearance].tintColor = [UIColor flatWhiteColor];
}

+ (void)readyButtonAppearance {
    [[UIButton appearance] setTitleColor:[UIColor flatMintColor] forState:UIControlStateNormal];
}

+ (void)readyTableAppearance {
    [UITableViewHeaderFooterView appearance].tintColor = [UIColor flatMintColor];
    [UITableViewHeaderFooterView appearance].textLabel.textColor = [UIColor flatWhiteColor];
    NSArray *textColorWhiteClassArray = @[[UITableViewHeaderFooterView class]];
    [[UILabel appearanceWhenContainedInInstancesOfClasses:textColorWhiteClassArray] setTextColor:[UIColor flatWhiteColor]];
}

+ (void)readyTextFiledAppearance {
    [UITextField appearance].tintColor = [UIColor flatMintColor];
}

@end
