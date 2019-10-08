//
//  EPOSPermissionns.m
//  EPOS_2.0
//
//  Created by 秦辉 on 2017/11/7.
//  Copyright © 2017年 LCSW. All rights reserved.
//

#import "EPOSPermissionns.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AFNetworking.h>
#import <Photos/Photos.h>

@implementation EPOSPermissionns

/**
 相机权限
 
 @return 返回一个bool值，表示是否可使用相机
 */
+ (BOOL)cameraPemission{
    BOOL isHavePemission = YES;
    
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                isHavePemission = YES;
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                isHavePemission = NO;
                break;
            case AVAuthorizationStatusNotDetermined:
                isHavePemission = YES;
                break;
        }
    }
    return isHavePemission;
}

/**
 请求相机权限
 
 @param completion 返回用户是否允许的状态值
 */
+ (void)requestCameraPemissionWithResult:(void(^)( BOOL granted))completion {
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                completion(YES);
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                completion(NO);
                break;
            case AVAuthorizationStatusNotDetermined:
            {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                         completionHandler:^(BOOL granted) {

                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 if (granted) {
                                                     completion(true);
                                                 } else {
                                                     completion(false);
                                                 }
                                             });

                                         }];
            }
                break;

        }
    }


}

/**
 请求照片权限
 
 @param completion 返回用户是否允许的状态值
 */
+ (void)photoPermissionWithResult:(void(^)( BOOL granted))completion{

    if (@available(iOS 10.0, *)) {

        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                switch (status) {
                    case PHAuthorizationStatusAuthorized: //已获取权限
                        completion(YES);
                        break;
                        
                    case PHAuthorizationStatusDenied: //用户已经明确否认了这一照片数据的应用程序访问
                        completion(NO);
                        break;
                        
                    case PHAuthorizationStatusRestricted://此应用程序没有被授权访问的照片数据。可能是家长控制权限
                        completion(NO);
                        break;
                        
                    default://其他。。。
                        completion(YES);
                        break;
                }
            });
        }];
    }else{
        PHAuthorizationStatus authorStatus = [PHPhotoLibrary authorizationStatus];
        if ( authorStatus == PHAuthorizationStatusDenied || authorStatus == PHAuthorizationStatusRestricted ) {
            completion(NO);
        }else{
            completion(YES);
        }
    }
}

/**
 监听网络状态
 
 @param completion 网络是否可用状态值
 */
+ (void)networkReachabilityStatus:(void (^)(BOOL))completion{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case AFNetworkReachabilityStatusUnknown: {
                    //未知网络
                    completion(YES);
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:{
                    //无法联网
                    completion(NO);
                }
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:{
                    //手机自带网络
                    completion(YES);
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi: {
                    //WIFI
                    completion(YES);
                }
                    break;
                default:
                    completion(NO);
                    break;
                    
            }
        });
    }];
    
}


@end
