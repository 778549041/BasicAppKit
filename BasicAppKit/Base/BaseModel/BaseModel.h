//
//  BaseModel.h
//  FUPay
//
//  Created by 徐军 on 2017/11/10.
//  Copyright © 2017年 徐军. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BaseModel : JSONModel

/**
 *  通过字典创建VO
 *
 *  @param aDict 字典
 *
 *  @return VO
 */
+ (instancetype)voWithDict:(NSDictionary *)aDict;

@end
