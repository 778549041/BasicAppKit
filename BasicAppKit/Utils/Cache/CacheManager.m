//
//  CacheManager.m
//  VEC_customer
//
//  Created by xujun on 2019/10/29.
//  Copyright © 2019 VMCSHOP. All rights reserved.
//

#import "CacheManager.h"
#import <SDImageCache.h>
#import <WebKit/WebKit.h>

@implementation CacheManager

/**
 *  计算沙盒相关路径的缓存
 *
 *  @param path 沙盒的路径
 *
 *  @return 缓存的大小（字符串）
 */
+ (NSString *)getCacheSizeWithFilePath:(NSString *)path {
    NSArray *subPathArr = [[NSFileManager defaultManager] subpathsAtPath:path];
    NSString *filePath  = nil;
    NSInteger totleSize = 0;
    for (NSString *subPath in subPathArr){
        filePath =[path stringByAppendingPathComponent:subPath];
        BOOL isDirectory = NO;
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExist || isDirectory || [filePath containsString:@".DS"]){
            continue;
        }
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        NSInteger size = [dict[@"NSFileSize"] integerValue];
        totleSize += size;
    }
    NSString *totleStr = nil;
    if (totleSize > 1000 * 1000){
        totleStr = [NSString stringWithFormat:@"%.2fM",totleSize / 1000.00f /1000.00f];
    }else if (totleSize > 1000){
        totleStr = [NSString stringWithFormat:@"%.2fKB",totleSize / 1000.00f ];
    }else{
        totleStr = [NSString stringWithFormat:@"%.2fB",totleSize / 1.00f];
    }
    return totleStr;
}

/**
 *  清除App的缓存
 */
+ (void)cleanAppCache {
    
    /**
     * 清除硬盘（沙盒）缓存
     */
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    [self clearCacheWithFilePath:cachesPath];
    NSLog(@"-----清除缓存结果-----%@", [self clearCacheWithFilePath:cachesPath] ? @"YES":@"NO");
    
    /**
     *  清除SDWebImage框架的缓存
     */
    [[SDImageCache sharedImageCache] clearMemory];// 清除磁盘缓存上的所有image
    [[SDImageCache sharedImageCache] deleteOldFilesWithCompletionBlock:^{
        
    }];// 清楚内存缓存上的所有image
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
    }];// 清除磁盘缓存上过期的image
    
    /**
     *  清除webView控件的缓存
     */
    [self deleteWebCache];
}

/**
 *  清除沙盒相关路径的缓存
 *
 *  @param path 沙盒相关路径
 *
 *  @return 是否清除成功
 */

+ (BOOL)clearCacheWithFilePath:(NSString *)path{
    
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSString *filePath = nil;
    NSError *error = nil;
    for (NSString *subPath in subPathArr)
    {
        filePath = [path stringByAppendingPathComponent:subPath];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"-----清除缓存的错误信息------%@",error);
            return NO;
        }
    }
    return YES;
}

/**
 *  清除webView控件的缓存
 */

+ (void)deleteWebCache {
    
    /**
     *  清除WKWebView的缓存
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {//版本判断 >= iOS9,只有iOS9的WKWebView才有清除下面的方法
        
        NSSet *websiteDataTypes
        
        = [NSSet setWithArray:@[
                                
                                WKWebsiteDataTypeDiskCache,
                               //WKWebsiteDataTypeOfflineWebApplicationCache,
                                WKWebsiteDataTypeMemoryCache,
                               //WKWebsiteDataTypeLocalStorage,
                               //WKWebsiteDataTypeCookies,
                               //WKWebsiteDataTypeSessionStorage,
                               //WKWebsiteDataTypeIndexedDBDatabases,
                               //WKWebsiteDataTypeWebSQLDatabases
                                
                                ]];
        
        //清除所有的web信息
        //NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            
        }];

    } else {
        
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
    /**
     *  清除UIWebView的缓存
     */
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    /**
     *  清除cookies
     */
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        
        [storage deleteCookie:cookie];
    }
}

@end
