//
//  BaseViewController.h
//  BasicAppKit
//
//  Created by xujun on 2019/8/9.
//  Copyright © 2019 xujun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

/**
 设置导航栏左边按钮
 */
- (void)setLeftButtons;

/**
 设置导航栏右边按钮
 */
- (void)setRightButtons;

@end

NS_ASSUME_NONNULL_END
