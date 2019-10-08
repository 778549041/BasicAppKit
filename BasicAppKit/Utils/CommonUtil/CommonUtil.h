//
//  CommonUtil.h
//  BasicAppKit
//
//  Created by xujun on 2019/8/9.
//  Copyright © 2019 xujun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonUtil : NSObject

AS_SINGLETON(CommonUtil)

/**
 //gif loading
 
 @param gifName GIF图名称
 @param waitingMessage 等待提示信息
 */
- (void)showLoadingWith:(NSString *)gifName waitingMessage:(NSString *)waitingMessage;

/**
 //时间戳转对应格式的时间
 
 @param timeStampStr 时间戳字符串
 @param fomatStr 转换后的时间格式 eg：yyyy-MM-dd
 @return 转换后得到的时间字符串
 */
- (NSString *)getTimeFromTimestamp:(NSString *)timeStampStr  fomatStr:(NSString *)fomatStr;

/**
 //比较两个时间的大小
 
 @param date1 被比较的时间
 @param date2 待比较的时间
 @return 判断大小的值，为0说明相等，为1说明date2比date1大，为-1说明date2比date1小
 */
- (NSInteger)comparedate:(NSDate *)date1 withDate:(NSDate *)date2;

/**
 //imageid获取图片地址
 
 @param imagesID 图片id
 @param callback 请求成功回调
 */
- (void)getImageUrlString:(NSArray *)imagesID Callback:(OTSCompletionBlock)callback;

/**
 //刷新tableview的某一行
 
 @param index 需要刷新的行
 @param tableView 需要刷新的table
 */
- (void)reloadIndexPath:(NSInteger)index forTableView:(UITableView *)tableView;

/**
 //为控制器定制导航栏
 
 @param viewController 需要定制导航栏的控制器
 @param title 返回按钮标题
 @param backBtn 返回按钮
 */
- (void)setNavViewFor:(UIViewController *)viewController title:(NSString *)title backBtn:(UIButton *)backBtn;

/**
 //弹出相机进行拍照或者拍视频并通过回调返回图片或者视频地址
 
 @param callBack 拍摄完成回调
 */
- (void)presentCameraController:(OTSCompletionBlock)callBack;

/**
 mov格式视频转换为MP4格式
 
 @param movUrl mov视频路径
 @return MP4格式视频路径
 */
- (NSURL *)_convert2Mp4:(NSURL *)movUrl;

//获取系统model
-(NSString*)model;

////获取系统localizedModel
-(NSString*)localizedModel;

/*
 *  设置行间距和字间距
 *
 *  @param string    字符串
 *  @param lineSpace 行间距
 *  @param kern      字间距
 *  @param font      字体大小
 *
 *  @return 富文本
 */
- (NSAttributedString *)getAttributedWithString:(NSString *)string WithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font;

/* 获取富文本的高度
 *
 * @param string    文字
 * @param lineSpace 行间距
 * @param kern      字间距
 * @param font      字体大小
 * @param width     文本宽度
 *
 * @return size
 */
- (CGSize)getAttributionHeightWithString:(NSString *)string lineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
