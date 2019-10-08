//
//  UIButton+WXD.h
//  EPOS_2.0
//
//  Created by 秦辉 on 2018/2/27.
//  Copyright © 2018年 LCSW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WXD)
/**
 *  为按钮添加点击间隔 eventTimeInterval秒
 */
@property (nonatomic, assign) NSTimeInterval eventTimeInterval;
/**
 *  bool YES 忽略点击事件   NO 允许点击事件
 */
@property (nonatomic, assign) BOOL isIgnoreEvent;
@end
