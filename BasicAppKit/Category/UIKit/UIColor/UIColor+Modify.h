//
//  UIColor+Modify.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/1/2.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Modify)
//翻转颜色
- (UIColor *)invertedColor;
//颜色半透明
- (UIColor *)colorForTranslucency;
//加亮
- (UIColor *)lightenColor:(CGFloat)lighten;
//变暗
- (UIColor *)darkenColor:(CGFloat)darken;

/**
 *  @brief  随机颜色
 *
 *  @return UIColor
 */
+ (UIColor *)RandomColor;
@end
