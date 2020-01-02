//
//  ShareSDKHelper.m
//  EPOS_2.0
//
//  Created by xujun on 2018/4/3.
//  Copyright © 2018年 LCSW. All rights reserved.
//

#import "ShareSDKHelper.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>

@implementation ShareSDKHelper

/// 初始化分享SDK
+ (void)initShareSDK {
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        [platformsRegister setupWeChatWithAppId:@"wx2b557709c7855d73" appSecret:@"02cfcff4e614584ccd2c2ecb15235f09"];
//        [platformsRegister setupQQWithAppId:@"" appkey:@""];
        [platformsRegister setupSinaWeiboWithAppkey:@"2066497986" appSecret:@"857033032e21eb0af1acd2f92d27562e" redirectUrl:@"https://app.ocarplay.com/openapi/toauth/callback/toauth_pam_sina/callback"];
    }];
}

/// 授权认证
/// @param authType 授权类型
/// @param success 成功回调
+ (void)authorize:(SSDKPlatformType)authType success:(void(^)(SSDKUser *user))success {
    [ShareSDK authorize:authType settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
                 NSLog(@"%@",user.dictionaryValue);
                success(user);
                 break;
             case SSDKResponseStateFail:
            {
                NSLog(@"--%@",error.description);
                //失败
                break;
            }
             case SSDKResponseStateCancel:
                 //用户取消授权
                 break;
                 
             default:
                 break;
        }
    }];
}

/// 分享
/// @param urlStr 分享的链接地址
/// @param text 分享的内容
/// @param image 分享的图片
/// @param title 分享的标题
/// @param tag 判断是哪种分享的标记
+ (void)share:(NSString *)urlStr text:(NSString *)text image:(NSString *)image title:(NSString *)title tag:(NSInteger)tag{
    
    SSDKPlatformType shareType;
    switch (tag) {
        case 0:
            shareType = SSDKPlatformSubTypeWechatTimeline;
            break;
        case 1:
            shareType = SSDKPlatformSubTypeWechatSession;
            break;
        case 2:
            shareType = SSDKPlatformSubTypeQZone;
            break;
        case 3:
            shareType = SSDKPlatformSubTypeQQFriend;
            break;
        case 4:
            shareType = SSDKPlatformTypeSinaWeibo;
            break;
            
        default:
            shareType = SSDKPlatformTypeAny;
            break;
    }
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    switch (shareType) {
        case SSDKPlatformSubTypeWechatTimeline:
        case SSDKPlatformSubTypeWechatSession:
            [shareParams SSDKSetupWeChatParamsByText:nil title:title url:[NSURL URLWithString:urlStr] thumbImage:nil image:image musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil sourceFileExtension:nil sourceFileData:nil type:SSDKContentTypeWebPage forPlatformSubType:shareType];
            break;
            
        case SSDKPlatformSubTypeQQFriend:
        case SSDKPlatformSubTypeQZone:
            [shareParams SSDKSetupQQParamsByText:nil title:title url:[NSURL URLWithString:urlStr] audioFlashURL:nil videoFlashURL:nil thumbImage:nil images:image type:SSDKContentTypeWebPage forPlatformSubType:shareType];
            break;
            
        case SSDKPlatformTypeSinaWeibo:
            [shareParams SSDKSetupSinaWeiboShareParamsByText:nil title:title images:image video:nil url:[NSURL URLWithString:urlStr] latitude:0 longitude:0 objectID:nil isShareToStory:YES type:SSDKContentTypeWebPage];
            break;
        default:
            break;
    }
    
    //有的平台要客户端分享需要加此方法，例如微博
//    [shareParams SSDKEnableUseClientShare];
    
    [ShareSDK share:shareType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"分享成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alertCon addAction:cancelAction];
                [[UIViewController currentViewController] presentViewController:alertCon animated:YES completion:nil];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                [alertCon addAction:cancelAction];
                [[UIViewController currentViewController] presentViewController:alertCon animated:YES completion:nil];
                break;
            }
            default:
                break;
        }
    }];
}

@end
