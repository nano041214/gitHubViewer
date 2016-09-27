import UIKit
import Chameleon

struct Theme {
    static func setupTheme() {
        Theme.setupTabBarAppearance()
        Theme.setupNavigationBarAppearance()
        Theme.setupTextFieldAppearance()
        Theme.setupButtonAppearance()
    }

    private static func setupTabBarAppearance() {
        UITabBar.appearance().tintColor = UIColor.flatWhiteColor()
        UITabBar.appearance().barTintColor = UIColor.flatMintColor()
    }

    private static func setupNavigationBarAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.flatWhiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.flatWhiteColor()]
        UINavigationBar.appearance().barTintColor = UIColor.flatMintColor()
        UIBarButtonItem.appearance().tintColor = UIColor.flatWhiteColor()
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }

    private static func setupTextFieldAppearance() {
        UITextField.appearance().tintColor = UIColor.flatMintColor()
    }

    private static func setupButtonAppearance() {
        UIButton.appearance().tintColor = UIColor.flatMintColor()
    }
}
