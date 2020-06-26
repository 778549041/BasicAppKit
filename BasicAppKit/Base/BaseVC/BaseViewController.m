//
//  BaseViewController.m
//  BasicAppKit
//
//  Created by xujun on 2019/8/9.
//  Copyright © 2019 xujun. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent; //白色
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self setLeftButtons];
    [self setRightButtons];
}

/**
 设置导航栏左边按钮
  */
- (void)setLeftButtons {
    
}

/**
 设置导航栏右边按钮
  */
- (void)setRightButtons {
    
}

/**
 结束编辑状态
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
