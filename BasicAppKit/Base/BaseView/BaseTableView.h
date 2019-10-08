//
//  BaseTableView.h
//  VEC_customer
//
//  Created by xujun on 2019/8/27.
//  Copyright © 2019 VMCSHOP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableView : UITableView
@property (nonatomic, getter=isLoading) BOOL loading;//是否正在刷新
@property (nonatomic, strong) void (^clickLoadingView)(BOOL isLoading);//点击刷新事件
@property (nonatomic, assign) BOOL isUnNet;//是否无网络
@property (nonatomic, assign) BOOL hiddenUpdateBtn;//是否隐藏按钮
@property (nonatomic, strong) NSString *imageName;//无数据展示图片
@property (nonatomic, strong) UIColor *bgColor;//视图背景色
@property (nonatomic, strong) UIColor *titleColor;//标题颜色
//网络加载失败
- (void)tableViewNetErr;
//网络加载成功
- (void)tableViewNetSuccess;
@end

NS_ASSUME_NONNULL_END
