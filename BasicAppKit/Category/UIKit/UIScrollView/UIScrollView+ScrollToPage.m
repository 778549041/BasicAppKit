//
//  UIScrollView+ScrollToPage.m
//  EPOS_2.0
//
//  Created by 徐军 on 2018/7/10.
//  Copyright © 2018年 LCSW. All rights reserved.
//

#import "UIScrollView+ScrollToPage.h"

@implementation UIScrollView (ScrollToPage)

- (void)scrollToPage:(NSInteger)toIndex of:(NSInteger)ofCount {
    CGFloat pageWidth = self.contentSize.width / ofCount;
    CGFloat x = toIndex * pageWidth;
    [self setContentOffset:CGPointMake(x, 0) animated:YES];
}

- (void)scrollToTop {
    [self scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

@end
