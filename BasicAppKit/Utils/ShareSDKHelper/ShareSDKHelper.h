//
//  ShareSDKHelper.h
//  EPOS_2.0
//
//  Created by xujun on 2018/4/3.
//  Copyright © 2018年 LCSW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>

@interface ShareSDKHelper : NSObject

/// 初始化分享SDK
+ (void)initShareSDK;

/// 授权认证
/// @param authType 授权类型
/// @param success 成功回调
+ (void)authorize:(SSDKPlatformType)authType success:(void(^)(SSDKUser *user))success;

/// 分享
/// @param urlStr 分享的链接地址
/// @param text 分享的内容
/// @param image 分享的图片
/// @param title 分享的标题
/// @param tag 判断是哪种分享的标记
+ (void)share:(NSString *)urlStr text:(NSString *)text image:(NSString *)image title:(NSString *)title tag:(NSInteger)tag;

@end
