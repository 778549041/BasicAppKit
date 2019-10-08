//
//  UITextField+Helper.m
//  EPOS_2.0
//
//  Created by 秦辉 on 2017/12/8.
//  Copyright © 2017年 LCSW. All rights reserved.
//

#import "UITextField+Helper.h"

@implementation UITextField (Helper)

- (void)addShadowView{
    self.layer.shadowColor = [UIColor blueColor].CGColor;
    self.layer.shadowOpacity = 0.2f;
    self.layer.shadowRadius = 10.f;
    self.layer.shadowOffset = CGSizeMake(0, 0);
}

- (void)removeShadowView{
    self.layer.shadowRadius = 0;
}

- (void)addCornerRadius{
   
    self.layer.cornerRadius = 4;
}

- (BOOL)handleMoneyFormatWithString:(NSString *)string{
    NSString *toBeString = self.text;
    NSString *str = [toBeString stringByAppendingString:string];
    if (self.text.length == 0) {//输入前文本为空
        self.text  = @"￥";
        if ([string isEqualToString:@"."]) {//若输入字符为小数点则停止输入，第一位不能为小数点
            self.text = @"￥0.";
            return NO;
        }
    }else{//输入前文本不为空
        
        if ([self.text isEqualToString:@"￥"] && [string isEqualToString:@"."]) {
            self.text = @"￥0.";
        }
        
        //输入之前只有一位并为0
        if (self.text.length == 2 && [self.text containsString:@"0"]) {
            if ([string isEqualToString:@"0"]) {//如果输入为0
                return NO;
            }else if(string.doubleValue > 0){//输入大于0
                self.text = [toBeString substringToIndex:0];
            }
        }
        
        if ([self.text rangeOfString:@"."].location != NSNotFound) {//输入之前有小数点
            if ([string isEqualToString:@"."]) {//若输入字符为小数点则停止输入
                return NO;
            }else{//字符不为小数点
                
                NSRange range = [str rangeOfString:@"."];
                NSString *dotStr = [str substringToIndex:range.location + 1];
                NSLog(@"---fuck 与小数点间隔 = %lu",str.length - dotStr.length);
                if (str.length - dotStr.length > 2) {//当前输入字符与小数点间隔大于2停止输入
                    return NO;
                }
            }
            
        }
    }
    //若输入为空格
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    return YES;
}

@end
