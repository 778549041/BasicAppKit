//
//  UITabBar+Badge.h
//  WOWSTATION
//
//  Created by xujun on 2019/8/8.
//  Copyright © 2019 xujun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (Badge)
//在tabbaritem上显示红点
- (void)showBadgeOnItemIndex:(int)index;
//隐藏红点
- (void)hideBadgeOnItemIndex:(int)index;
@end

NS_ASSUME_NONNULL_END
