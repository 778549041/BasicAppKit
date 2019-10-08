//
//  UITextField+Helper.h
//  EPOS_2.0
//
//  Created by 秦辉 on 2017/12/8.
//  Copyright © 2017年 LCSW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Helper)

//加阴影
- (void)addShadowView;
//去除阴影
- (void)removeShadowView;

//加圆角
- (void)addCornerRadius;

- (BOOL)handleMoneyFormatWithString:(NSString *)string;

@end
