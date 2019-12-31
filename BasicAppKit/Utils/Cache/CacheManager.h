//
//  CacheManager.h
//  VEC_customer
//
//  Created by xujun on 2019/10/29.
//  Copyright © 2019 VMCSHOP. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CacheManager : NSObject

/**
 *  计算沙盒相关路径的缓存
 *
 *  @param path 沙盒的路径
 *
 *  @return 缓存的大小（字符串）
 */
+ (NSString *)getCacheSizeWithFilePath:(NSString *)path;

/**
 *  清除App的缓存
 */
+ (void)cleanAppCache;

@end

NS_ASSUME_NONNULL_END
