//
//  ShareSDKHelper.m
//  EPOS_2.0
//
//  Created by xujun on 2018/4/3.
//  Copyright © 2018年 LCSW. All rights reserved.
//

#import "ShareSDKHelper.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@implementation ShareSDKHelper

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
            
        default:
            shareType = SSDKPlatformTypeAny;
            break;
    }
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    switch (shareType) {
        case SSDKPlatformSubTypeWechatTimeline:
        case SSDKPlatformSubTypeWechatSession:
            [shareParams SSDKSetupWeChatParamsByText:nil title:title url:[NSURL URLWithString:urlStr] thumbImage:nil image:image musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeWebPage forPlatformSubType:shareType];
            break;
            
        case SSDKPlatformSubTypeQQFriend:
        case SSDKPlatformSubTypeQZone:
            [shareParams SSDKSetupQQParamsByText:nil title:title url:[NSURL URLWithString:urlStr] thumbImage:nil image:image type:SSDKContentTypeWebPage forPlatformSubType:shareType];
            
        default:
            break;
    }
    
    //有的平台要客户端分享需要加此方法，例如微博
    [shareParams SSDKEnableUseClientShare];
    
    [ShareSDK share:shareType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@",error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            default:
                break;
        }
    }];
}

@end
