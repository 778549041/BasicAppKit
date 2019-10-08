//
//  UIStoryboard+install.m
//  EPOS_2.0
//
//  Created by 秦辉 on 2017/11/16.
//  Copyright © 2017年 LCSW. All rights reserved.
//

#import "UIStoryboard+install.h"

@implementation UIStoryboard (install)

+(__kindof UIViewController *)installName:(NSString *)name AndIdentifier:(NSString *)identifier{
    return [[UIStoryboard storyboardWithName:name bundle:nil] instantiateViewControllerWithIdentifier:identifier];
}

@end
