//
//  NSDate+HKExtension.h
//  Takeaway
//
//  Created by hank on 2020/9/1.
//  Copyright © 2020 CJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (HKExtension)
/** 获取当前日期*/
+ (NSString *)currentDateStringWithFormat:(NSString *)format;

/** 比较两个日期大小*/
+ (int)compareDate:(NSString*)startDate withDate:(NSString*)endDate format:(NSString *)format;

/** 比较两个日期大小 */
+ (NSComparisonResult)compareSize:(NSString *)startTime endTime:(NSString *)endTime format:(NSString *)format;
/** 比较两个日期间隔 */
+ (NSInteger)compareInterval:(NSString *)startTime endTime:(NSString *)endTime format:(NSString *)format;

/** 获取上一个月日期 */
+ (NSString *)getBeforeOneMonth:(NSString *)currentMonth format:(NSString *)format;
/** 字符串转化为时间 */
+ (NSDate *)stringToDate:(NSString *)string format:(NSString *)format;
/** 时间转化为字符串 */
+ (NSString *)dateToString:(NSDate *)date format:(NSString *)format;
/** 时间戳转化 */
+ (NSString *)timeStampToDateString:(NSString *)timeStamp format:(NSString *)format;

/** 计算年龄 */
+ (int)getAgeWithDate:(NSString*)birthDate;
/** 是否是今日 */
+ (BOOL)isToday:(NSDate *)date;

+ (BOOL)compareDateWithYears:(NSString *)startDate endDate:(NSString *)endDate format:(NSString *)format;
+ (NSString *)stringWithTime:(NSString *)time value:(NSInteger)value format:(NSString *)format;

+ (NSString *)stringWithFormat:(NSString *)format timeStamp:(NSTimeInterval)stamp;

- (NSString *)dateWithFormat:(NSString *)format;

+ (BOOL)compareDateWithStartTimeStamp:(NSTimeInterval)startTimeStamp endTimeStamp:(NSTimeInterval)endTimeStamp;

+ (BOOL)compareDateWithStartTimeString:(NSString *)startTimeString endTimeString:(NSString *)endTimeString;

/** 判断时间戳是否超过支付时间*/
+ (BOOL)compareTimeIntervalIsOutofTime:(long long)time;

@end

NS_ASSUME_NONNULL_END
