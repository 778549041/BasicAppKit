//
//  BaseTableView.m
//  VEC_customer
//
//  Created by xujun on 2019/8/27.
//  Copyright © 2019 VMCSHOP. All rights reserved.
//

#import "BaseTableView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface BaseTableView ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation BaseTableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configTableView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self configTableView];
    }
    return self;
}

- (void)configTableView {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.emptyDataSetDelegate = self;
    self.emptyDataSetSource = self;
    self.hiddenUpdateBtn = YES;
    self.tableFooterView = [UIView new];
    if (isIOS11){
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    };
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}
//set loading状态
- (void)setLoading:(BOOL)loading {
    if (self.isLoading == loading) {
        return;
    }
    
    _loading = loading;
    
    [self reloadEmptyDataSet];
}
//网络加载失败
- (void)tableViewNetErr{
    [self.mj_footer endRefreshing];
    [self.mj_header endRefreshing];
    self.isUnNet = YES;
    self.loading = NO;
    [self.mj_footer endRefreshingWithNoMoreData];
}
//网络请求成功
- (void)tableViewNetSuccess{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    self.loading = NO;
}

#pragma mark  DZNEmptyDataSetSource  DZNEmptyDataSetDelegate
//空数据展示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.isLoading) {
        return [UIImage imageNamed:@"loading_imgBlue_78x78" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    }else {
        if (self.isUnNet) { //MARK:无网络
            self.isUnNet = NO;
            return GetImage(@"icon_net_error");
        }
        return self.imageName ? GetImage(self.imageName) : GetImage(@"icon_empty_blue");//显示默认图
    }
    return nil;
}
//加载动画
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
    
}
//是否允许动画
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView{
    return self.isLoading;
}
//空数据视图背景色
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    return self.bgColor;
}

//按钮图片
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (self.hiddenUpdateBtn) { //隐藏按钮
        return nil;
    }
    
    if (!self.isLoading){
        if (self.isUnNet){
            return GetImage(@"DZ_reload");
        }
        return GetImage(@"DZ_update");
    }else{
        return nil;
    }
}
//按钮点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{

    self.loading = YES;
    if (self.clickLoadingView){
        self.clickLoadingView(YES);
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loading = NO;
    });
}
//图片点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    self.loading = YES;
    if (self.clickLoadingView){
        self.clickLoadingView(YES);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loading = NO;
    });
}
//详细描述
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    return nil;
}
//视图centerY
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -self.tableHeaderView.frame.size.height/2.0f - 50;
}

//标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"";
    if (self.isUnNet){
        text = @"哎呀，网络开了个小差";
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:20.0f],
                                     NSForegroundColorAttributeName: [UIColor colorWithRed:0/255.0 green:69/255.0 blue:208/255.0 alpha:1.0]};
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
    if (self.isLoading){
        text = @"空空如也";
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:20.0f],
                                     NSForegroundColorAttributeName: self.titleColor};
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
    return nil;
}


@end
