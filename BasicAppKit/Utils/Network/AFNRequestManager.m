//
//  AFNRequestManager.m
//  EPOS_2.0
//
//  Created by 秦辉 on 2017/10/31.
//  Copyright © 2017年 LCSW. All rights reserved.
//

#import "AFNRequestManager.h"

@interface AFNRequestManager(){
    AFHTTPSessionManager *_manager;
}
@end;

@implementation AFNRequestManager
DEF_SINGLETON(AFNRequestManager)


- (instancetype)init {
    if (self = [super init]){
        _serverUrl = @"https://app.ocarplay.com/";
        _manager = [AFHTTPSessionManager manager];
        NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
        NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
        NSLog(@"%@", cerData);
        // AFSSLPinningModeCertificate 使用证书验证模式
        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone withPinnedCertificates:[[NSSet alloc] initWithArray:[[NSArray alloc] initWithObjects:cerData, nil]]];
        // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
        // 如果是需要验证自建证书，需要设置为YES
        _manager.securityPolicy.allowInvalidCertificates = YES;
        //validatesDomainName 是否需要验证域名，默认为YES；
        //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
        //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
        //如置为NO，建议自己添加对应域名的校验逻辑。
        [_manager.securityPolicy setValidatesDomainName:NO];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
        _manager.requestSerializer.timeoutInterval = 10.0f;//设置请求超时时间
        
    }
    return self;
    
}

/**
设置cookie以及header参数
 */
- (void)setCookie:(NSString *)SID {
    [_manager.requestSerializer setValue:@"YES" forHTTPHeaderField:@"X-Requested-isWEBAPP"];
    [_manager.requestSerializer setHTTPShouldHandleCookies:YES];
    [_manager.requestSerializer setValue:[NSString stringWithFormat:@"%@=%@", @"_SID", SID] forHTTPHeaderField:@"Cookie"];
}

/**
 * AF数据请求
 */
-(void)requestAFNWURL:(NSString *)URLString
           httpMethod:(NSInteger)method
           parameters:(id)parameters
           WaitingMessage:(NSString *)waitingMessage
           Callback:(OTSCompletionBlock)callback{
    
    URLString = [NSString stringWithFormat:@"%@%@",self.serverUrl,[URLString stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    
    switch (method) {
        case GET:{
            
            [_manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [SVProgressHUD dismiss];
                callback(responseObject,nil);
                NSLog(@"success %@", responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                callback(nil,error);
                NSLog(@"failure %@", error);
                if (error.code == -1001) {
                    [MBProgressHUD showError:@"请求超时"];
                }
            }];
        }
            break;
            
        case POST:{
            
            [_manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [SVProgressHUD dismiss];
                callback(responseObject,nil);
                NSLog(@"success %@", responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD dismiss];
                callback(nil,error);
                NSLog(@"failure %@", error);
                if (error.code == -1001) {
                    [MBProgressHUD showError:@"请求超时"];
                }
            }];
        }
            break;
            
        default:
            break;
    }
    
    
}

/**
 表单格式提交数据
 
 @param URLString 接口地址
 @param parameters 参数
 @param waitingMessage 等待提示信息
 @param callback 数据回调
 */
- (void)formRequestAFNWURL:(NSString *)URLString parameters:(id)parameters WaitingMessage:(NSString *)waitingMessage Callback:(OTSCompletionBlock)callback {
    
    URLString = [NSString stringWithFormat:@"%@/%@",self.serverUrl,[URLString stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    
    [_manager POST:URLString parameters:parameters constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        callback(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        callback(nil,error);
        NSLog(@"failure %@", error);
        if (error.code == -1001) {
            [MBProgressHUD showError:@"请求超时"];
        }
    }];
}

@end
