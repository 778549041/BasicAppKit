//
//  JSONHelper.h
//  FUPay
//
//  Created by 徐军 on 2017/12/29.
//  Copyright © 2017年 徐军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONHelper : NSObject

/**
 json转字典

 @param jsonString json字符串
 @return 转换之后得到的字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString ;

/**
 json转数组

 @param jsonString json字符串
 @return 转换后得到的数组
 */
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString ;

/**
 对象转json字符串

 @param theObject 对象
 @return json字符串
 */
+ (NSString*)jsonSerize:(id)theObject;

/**
 将返回数据里的list数组json字符串转成数组并得到解析完全的字典对象

 @param dic 字典对象，但是里面包含的list数组是json格式的串
 @param listStr list数组对应的key
 @return 最终得到的字典对象
 */
+ (NSDictionary *)dicHandleWithKeySign:(NSDictionary *)dic WtihListName:(NSString *)listStr;
@end
