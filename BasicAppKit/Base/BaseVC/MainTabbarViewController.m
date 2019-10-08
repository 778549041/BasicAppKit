//
//  MainTabbarViewController.m
//  BasicAppKit
//
//  Created by xujun on 2019/8/9.
//  Copyright © 2019 xujun. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "ViewController.h"
#import "BaseNavigationViewController.h"

@interface MainTabbarViewController ()

@end

@implementation MainTabbarViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupTabBarController];
    }
    return self;
}

- (void)setupTabBarController {
    /// 设置TabBar属性数组
    self.tabBarItemsAttributes = [self tabBarItemsAttributesForController];
    /// 设置控制器数组
    self.viewControllers =[self mpViewControllers];
    self.moreNavigationController.navigationBarHidden = YES;
    //加这两行代码，以免被系统渲染成蓝色
    self.tabBar.tintColor = [UIColor redColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    //去掉顶部黑线
    self.tabBar.clipsToBounds = YES;
    self.tabBar.backgroundColor = [UIColor clearColor];
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage new]];
}


//控制器设置
- (NSArray *)mpViewControllers {
    
    ViewController *firstViewController = [[ViewController alloc] init];
    firstViewController.title = @"首页";
    UINavigationController *firstNavigationController = [[BaseNavigationViewController alloc] initWithRootViewController:firstViewController];
    
    
    ViewController *secondViewController = [[ViewController alloc] init];
    secondViewController.title = @"我的账户";
    UINavigationController *secondNavigationController = [[BaseNavigationViewController alloc]initWithRootViewController:secondViewController];
    
    ViewController *thirdViewController = [[ViewController alloc] init];
    thirdViewController.title = @"我的";
    UINavigationController *thirdNavigationController = [[BaseNavigationViewController alloc] initWithRootViewController:thirdViewController];
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 ];
    return viewControllers;
}

//TabBar文字跟图标设置
- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"tab_icon1_nor",
                                                 CYLTabBarItemSelectedImage : @"tab_icon1_sel",
                                                 };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"账户",
                                                 CYLTabBarItemImage : @"tab_icon2_nor",
                                                 CYLTabBarItemSelectedImage : @"tab_icon2_sel",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage : @"tab_icon3_nor",
                                                  CYLTabBarItemSelectedImage : @"tab_icon3_sel"
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

@end
