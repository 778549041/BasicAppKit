//
//  BaseModel.m
//  FUPay
//
//  Created by 徐军 on 2017/11/10.
//  Copyright © 2017年 徐军. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)init
{
    if (self = [super init]) {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            [JSONModel setGlobalKeyMapper:[[JSONKeyMapper alloc] initWithDictionary:@{@"id": @"nid"}]];
        });
    }
    return self;
}

/**
 *  重写父类方法，默认可选
 *
 *  @param propertyName 属性名称
 *
 *  @return bool
 */
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+ (instancetype)voWithDict:(NSDictionary *)aDict
{
    if (![aDict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    return [[self alloc] initWithDictionary:aDict error:nil];
}

@end
