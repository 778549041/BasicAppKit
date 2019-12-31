//
//  MainTabbarViewController.m
//  BasicAppKit
//
//  Created by xujun on 2019/8/9.
//  Copyright © 2019 xujun. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
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
    self.moreNavigationController.navigationBarHidden = NO;
    //加这两行代码，以免被系统渲染成蓝色
    self.tabBar.tintColor = [UIColor redColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    //去掉顶部黑线
//    self.tabBar.clipsToBounds = YES;
//    self.tabBar.backgroundColor = [UIColor clearColor];
//    [self.tabBar setBackgroundImage:[UIImage new]];
//    [self.tabBar setShadowImage:[UIImage new]];
}


//控制器设置
- (NSArray *)mpViewControllers {
    
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    firstViewController.title = @"首页";
    UINavigationController *firstNavigationController = [[BaseNavigationViewController alloc] initWithRootViewController:firstViewController];
    
    
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    secondViewController.title = @"我的账户";
    UINavigationController *secondNavigationController = [[BaseNavigationViewController alloc]initWithRootViewController:secondViewController];
    
    ThirdViewController *thirdViewController = [[ThirdViewController alloc] init];
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
                                                 CYLTabBarItemImage : @"icon_category",
                                                 CYLTabBarItemSelectedImage : @"icon_category_selected",
                                                 };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"账户",
                                                 CYLTabBarItemImage : @"icon_home",
                                                 CYLTabBarItemSelectedImage : @"icon_home_selected",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage : @"icon_me",
                                                  CYLTabBarItemSelectedImage : @"icon_me_selected"
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

@end
