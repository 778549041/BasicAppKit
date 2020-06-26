//
//  ShareSDKHelper.h
//  EPOS_2.0
//
//  Created by xujun on 2018/4/3.
//  Copyright © 2018年 LCSW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareSDKHelper : NSObject

+ (void)share:(NSString *)urlStr text:(NSString *)text image:(NSString *)image title:(NSString *)title tag:(NSInteger)tag;

@end
