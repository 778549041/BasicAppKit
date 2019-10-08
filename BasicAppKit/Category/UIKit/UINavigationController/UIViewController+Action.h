//
//  UIViewController+Action.h
//  EPOS_2.0
//
//  Created by 秦辉 on 2017/12/27.
//  Copyright © 2017年 LCSW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Action)

- (void)addNavigationViewWithTitle:(NSString *)title andBgColor:(UIColor *)color clickBtnWithClickBackBlock:(void(^)())block;

+ (UIViewController*) currentViewController;

@end
