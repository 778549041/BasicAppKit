//
//  UIScrollView+ScrollToPage.h
//  EPOS_2.0
//
//  Created by 徐军 on 2018/7/10.
//  Copyright © 2018年 LCSW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ScrollToPage)
//从总数ofCount滑动到指定index
- (void)scrollToPage:(NSInteger)toIndex of:(NSInteger)ofCount;
//滑动到最顶部
- (void)scrollToTop;

@end
