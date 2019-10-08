//
//  JSONHelper.m
//  FUPay
//
//  Created by 徐军 on 2017/12/29.
//  Copyright © 2017年 徐军. All rights reserved.
//

#import "JSONHelper.h"

@implementation JSONHelper

/**
 json转字典
 
 @param jsonString json字符串
 @return 转换之后得到的字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dic;
}
/**
 json转数组
 
 @param jsonString json字符串
 @return 转换后得到的数组
 */
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString{
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return array;
}

/**
 将返回数据里的list数组json字符串转成数组并得到解析完全的字典对象
 
 @param dic 字典对象，但是里面包含的list数组是json格式的串
 @param listStr list数组对应的key
 @return 最终得到的字典对象
 */
+ (NSDictionary *)dicHandleWithKeySign:(NSDictionary *)dic WtihListName:(NSString *)listStr{
    if (dic[listStr] != nil && ![dic[listStr] isKindOfClass:[NSNull class]]) {
        NSArray *pageArray = [JSONHelper arrayWithJsonString:dic[listStr]];
        NSMutableDictionary *dataDic = [dic mutableCopy];
        dataDic[listStr] = pageArray;
        return [dataDic mutableCopy];
    }
    return [dic mutableCopy];
}

/**
 对象转json字符串
 
 @param theObject 对象
 @return json字符串
 */
+(NSString*)jsonSerize:(id)theObject
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theObject options:NSJSONWritingPrettyPrinted error:&error];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
