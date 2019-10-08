//
//  NSDate+Formatter.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Copyright (C) 2013 by Christopher Meyer
//  http://schwiiz.org/
//

#import <Foundation/Foundation.h>

@interface NSDate (Formatter)

+(NSDateFormatter *)formatter;
+(NSDateFormatter *)formatterWithoutTime;
+(NSDateFormatter *)formatterWithoutDate;

-(NSString *)formatWithUTCTimeZone;
-(NSString *)formatWithLocalTimeZone;
-(NSString *)formatWithTimeZoneOffset:(NSTimeInterval)offset;
-(NSString *)formatWithTimeZone:(NSTimeZone *)timezone;

-(NSString *)formatWithUTCTimeZoneWithoutTime;
-(NSString *)formatWithLocalTimeZoneWithoutTime;
-(NSString *)formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset;
-(NSString *)formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone;

-(NSString *)formatWithUTCWithoutDate;
-(NSString *)formatWithLocalTimeWithoutDate;
-(NSString *)formatWithTimeZoneOffsetWithoutDate:(NSTimeInterval)offset;
-(NSString *)formatTimeWithTimeZone:(NSTimeZone *)timezone;


+ (NSString *)currentDateStringWithFormat:(NSString *)format;
+ (NSDate *)dateWithSecondsFromNow:(NSInteger)seconds;
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;
- (NSString *)dateWithFormat:(NSString *)format;
+ (NSDate *)getDayTime:(NSDate *)transformDate;
+ (NSInteger)comparedate:(NSDate *)date1 withDate:(NSDate *)date2;
+ (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate;
+ (NSString*)getWeekDay:(NSString*)currentStr;
+ (NSInteger)compare:(NSDate *)startTime to:(NSDate *)endTime;
+ (NSArray *)getWeekBeginAndEndWith:(NSDate *)newDate;
+ (NSArray *)getWeekBeginAndEndWith:(NSDate *)newDate AndFormatter:(NSString *)formatStr;

+ (BOOL)isSameWeek:(NSDate *)date;
+ (BOOL)isSameMonth:(NSDate *)date;
+ (NSDate *)getLastWeekDate:(NSDate *)date;
@end
