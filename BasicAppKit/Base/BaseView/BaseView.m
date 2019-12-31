//
//  BaseView.m
//  BasicAppKit
//
//  Created by xujun on 2019/10/9.
//  Copyright © 2019 xujun. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame;
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/// 渲染视图
/// @param data 数据
- (void)updateViewWithData:(id)data {
    
}

/// 渲染视图
/// @param data 数据
/// @param extraData 额外的数据
- (void)updateViewWithData:(id)data extraData:(id)extraData {
    
}

@end
