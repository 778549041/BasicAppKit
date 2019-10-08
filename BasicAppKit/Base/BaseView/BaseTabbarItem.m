//
//  BaseTabbarItem.m
//  VEC_customer
//
//  Created by xujun on 2019/8/17.
//  Copyright © 2019 VMCSHOP. All rights reserved.
//

#import "BaseTabbarItem.h"

@implementation BaseTabbarItem

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.selectedImage = [self.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter" size:13.0f]} forState:UIControlStateNormal];
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter" size:13.0f]} forState:UIControlStateSelected];
    }
    return self;
}

@end
