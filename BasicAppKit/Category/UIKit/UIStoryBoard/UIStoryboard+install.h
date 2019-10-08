//
//  UIStoryboard+install.h
//  EPOS_2.0
//
//  Created by 秦辉 on 2017/11/16.
//  Copyright © 2017年 LCSW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (install)
+ (__kindof UIViewController *)installName:(NSString *)name AndIdentifier:(NSString *)identifier;
@end
