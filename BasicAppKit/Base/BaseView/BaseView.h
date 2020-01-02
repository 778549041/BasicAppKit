//
//  BaseView.h
//  BasicAppKit
//
//  Created by xujun on 2019/10/9.
//  Copyright © 2019 xujun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UIView

/// 渲染视图
/// @param data 数据
- (void)updateViewWithData:(id)data;

/// 渲染视图
/// @param data 数据
/// @param extraData 额外的数据
- (void)updateViewWithData:(id)data extraData:(id)extraData;

@end

NS_ASSUME_NONNULL_END
