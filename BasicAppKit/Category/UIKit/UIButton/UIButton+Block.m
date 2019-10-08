//
//  UIButton+Block.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>
static const void *UIButtonBlockKey = &UIButtonBlockKey;

@implementation UIButton (Block)
-(void)addActionHandler:(TouchedBlock)touchHandler{
    objc_setAssociatedObject(self, UIButtonBlockKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(actionTouched:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)actionTouched:(UIButton *)btn{
    TouchedBlock block = objc_getAssociatedObject(self, UIButtonBlockKey);
    if (block) {
        block(btn.tag);
    }
}
- (void)alignImageAndTitleVertically:(CGFloat)padding {
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGFloat totalHeight = imageSize.height + titleSize.height + padding;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight-imageSize.height), (self.frame.size.width - imageSize.width)/2 - 5, 0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(self.frame.size.width - titleSize.width)/2 - 10, -(totalHeight - titleSize.height), 0);
}

//添加阴影
- (void)addShadowView{
    self.layer.shadowColor = HEXCOLOR(0x4675cc).CGColor;
    self.layer.shadowOpacity = 0.2f;
    self.layer.shadowRadius = 10.f;
    self.layer.shadowOffset = CGSizeMake(0, 0);
   
}

- (void)addBorderWithRadius:(CGFloat)radius AndColor:(UIColor *)color{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = radius;
}

@end

