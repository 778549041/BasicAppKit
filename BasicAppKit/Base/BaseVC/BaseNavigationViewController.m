//
//  BaseNavigationViewController.m
//  BasicAppKit
//
//  Created by xujun on 2019/8/9.
//  Copyright © 2019 xujun. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//跳转
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0){
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 60, 40);
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // 注意:一定要在按钮内容有尺寸的时候,设置才有效果
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        // 设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}
//返回
- (void)back{
    [self popViewControllerAnimated:YES];
}

//要修改statusbarstyle并且生效，必须加这个方法
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}
//要隐藏statusbar并且生效，必须加这个方法
- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

@end
