//
//  AFNRequestManager.h
//  EPOS_2.0
//
//  Created by 秦辉 on 2017/10/31.
//  Copyright © 2017年 LCSW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

enum HTTPMETHOD{
    GET = 0, //GET请求
    POST = 1, //POST请求
};
@interface AFNRequestManager : NSObject
@property(nonatomic,strong) NSString* serverUrl;
AS_SINGLETON(AFNRequestManager)

/**
 * AF数据请求 单例模式
 */
-(void)requestAFNWURL:(NSString *)URLString
           httpMethod:(NSInteger)method
           parameters:(id)parameters
           WaitingMessage:(NSString *)waitingMessage
           Callback:(OTSCompletionBlock)callback;

/**
 表单格式提交数据
 
 @param URLString 接口地址
 @param parameters 参数
 @param waitingMessage 等待提示信息
 @param callback 数据回调
 */
- (void)formRequestAFNWURL:(NSString *)URLString
                parameters:(id)parameters
            WaitingMessage:(NSString *)waitingMessage
                  Callback:(OTSCompletionBlock)callback;

/**
 设置cookie以及header参数
 */
- (void)setCookie:(NSString *)SID;

@end
