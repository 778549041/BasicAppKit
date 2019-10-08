//
//  EPOSPermissionns.h
//  EPOS_2.0
//
//  Created by 秦辉 on 2017/11/7.
//  Copyright © 2017年 LCSW. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EPOSPermissionns : NSObject


/**
 相机权限

 @return 返回一个bool值，表示是否可使用相机
 */
+ (BOOL)cameraPemission;

/**
 请求相机权限

 @param completion 返回用户是否允许的状态值
 */
+ (void)requestCameraPemissionWithResult:(void(^)( BOOL granted))completion;

/**
 请求照片权限

 @param completion 返回用户是否允许的状态值
 */
+ (void)photoPermissionWithResult:(void(^)( BOOL granted))completion;

/**
 监听网络状态

 @param completion 网络是否可用状态值
 */
+ (void)networkReachabilityStatus:(void(^)(BOOL granted))completion;


@end
