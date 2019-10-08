//
//  NSString+RemoveEmoji.m
//  NSString+RemoveEmoji
//
//  Created by Jakey on 15/5/13.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//
#import "NSString+RemoveEmoji.h"

@implementation NSString (RemoveEmoji)
/**
 *  @brief  是否包含emoji
 *
 *  @return 是否包含emoji
 */
- (BOOL)isEmoji {
    
    if ([self isFuckEmoji]) {
        return YES;
    }
    const unichar high = [self characterAtIndex:0];
    
   
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
    // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
//
}
-(BOOL)isFuckEmoji{
    NSArray *fuckArray =@[@"⭐",@"㊙️",@"㊗️",@"⬅️",@"⬆️",@"⬇️",@"⤴️",@"⤵️",@"#️⃣",@"0️⃣",@"1️⃣",@"2️⃣",@"3️⃣",@"4️⃣",@"5️⃣",@"6️⃣",@"7️⃣",@"8️⃣",@"9️⃣",@"〰",@"©®",@"〽️",@"‼️",@"⁉️",@"⭕️",@"⬛️",@"⬜️",@"⭕",@"",@"⬆",@"⬇",@"⬅",@"㊙",@"㊗",@"⭕",@"©®",@"⤴",@"⤵",@"〰",@"†",@"⟹",@"ツ",@"ღ",@"©",@"®"];
//    NSString *test = @"⭐㊙️㊗️⬅️⬆️⬇️⤴️⤵️#️⃣0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣〰©®〽️‼️⁉️⭕️⬛️⬜️⭕⬆⬇⬅㊙㊗⭕©®⤴⤵〰†⟹ツღ";
//    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0;i < [test length]; i++)
//    {
//        [array addObject:[test substringWithRange:NSMakeRange(i,1)]];
//    }
    BOOL result = NO;
    for(NSString *string in fuckArray){
        if ([self isEqualToString:string]) {
            return YES;
        }
    }
    if ([@"\u2b50\ufe0f" isEqualToString:self]) {
        result = YES;
        
    }
    return result;
}

- (BOOL)isIncludingEmoji {
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
        if ([substring isEmoji]) {
            *stop = YES;
            result = YES;
        }
    }];
    
    return result;
}
/**
 *  @brief  删除掉包含的emoji
 *
 *  @return 清除后的string
 */
- (instancetype)removedEmojiString {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
        [buffer appendString:([substring isEmoji])? @"": substring];
    }];
    
    return buffer;
}

- (NSString *)isString{
    if ([self isKindOfClass:[NSNull class]] || self == nil){
        return @"";
    }
    return self;
}

- (NSString *)handleFloatString{
    
    NSString *str = [NSString stringWithFormat:@"%f",[self floatValue]/10];
    long len = str.length;
    for (int i = 0; i < len; i++){
        if (![str  hasSuffix:@"0"]){
            break;
        }else{
            str = [str substringToIndex:[str length]-1];
        }
    }
    if ([str hasSuffix:@"."]){ //避免像2.0000这样的被解析成2.
        //s.substring(0, len - i - 1);
        return [str substringToIndex:[str length]-1];
    }
    else{
        return str;
    }
    
}

@end
