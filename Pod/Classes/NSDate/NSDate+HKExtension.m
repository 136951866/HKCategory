//
//  NSDate+HKExtension.m
//  Takeaway
//
//  Created by hank on 2020/9/1.
//  Copyright © 2020 CJ. All rights reserved.
//

#import "NSDate+HKExtension.h"

@implementation NSDate (HKExtension)
+ (NSString *)currentDateStringWithFormat:(NSString *)format {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *currentDateStr = [dateFormatter stringFromDate:currentDate];
    return currentDateStr;
}

+ (int)compareDate:(NSString*)startDate withDate:(NSString*)endDate format:(NSString *)format {
    int comparisonResult;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *date1 = [formatter dateFromString:startDate];
    NSDate *date2 = [formatter dateFromString:endDate];
    NSComparisonResult result = [date1 compare:date2];
    switch (result)
    {
            //date1<date2
        case NSOrderedAscending:
            comparisonResult = 1;
            break;
            //date1>date2
        case NSOrderedDescending:
            comparisonResult = -1;
            break;
            //date1=date2
        case NSOrderedSame:
            comparisonResult = 0;
            break;
        default:
            NSLog(@"erorr dates %@, %@", date1, date2);
            break;
    }
    return comparisonResult;
}

+ (NSComparisonResult)compareSize:(NSString *)startTime endTime:(NSString *)endTime format:(NSString *)format {
    NSDate *startDate = [self stringToDate:startTime format:format];
    NSDate *endDate = [self stringToDate:endTime format:format];
    NSComparisonResult result = [startDate compare:endDate];
    return result;
}

+ (NSInteger)compareInterval:(NSString *)startTime endTime:(NSString *)endTime format:(NSString *)format {
    NSDate *startDate = [self stringToDate:startTime format:format];
    NSDate *endDate = [self stringToDate:endTime format:format];
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:startDate toDate:endDate options:0];
    
    return components.month;
}

+ (NSString *)getBeforeOneMonth:(NSString *)currentMonth format:(NSString *)format {
    NSDate *currentDate = [NSDate stringToDate:currentMonth format:format];//@"yyyy-MM"
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:currentDate];
    [components setMonth:-1];
    NSDate *newCurrentDate = [calendar dateByAddingComponents:components toDate:currentDate options:0];
    return [self dateToString:newCurrentDate format:format];
}

+ (NSDate *)stringToDate:(NSString *)string format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    formatter.locale = [NSLocale currentLocale];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

+ (NSString *)dateToString:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeStampToDateString:(NSString *)timeStamp format:(NSString *)format {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp.doubleValue / 1000.0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (int)getAgeWithDate:(NSString*)birthDate {
    //计算年龄
 
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSDate *birthDay = [dateFormatter dateFromString:birthDate];
    //当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
    NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
    int age = ((int)time)/(3600*24*365);
    return age;
}

+ (BOOL)isToday:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate new]];
    NSDateComponents *curComponents = [calendar components:unit fromDate:date];
    
    return (curComponents.year == nowComponents.year) && (curComponents.month == nowComponents.month) && (curComponents.day == nowComponents.day);
}
//判断 查询时间不能超过一年
+ (BOOL)compareDateWithYears:(NSString *)startDate endDate:(NSString *)endDate format:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format; // @"yyyy-MM";
    NSDate *d1 = [formatter dateFromString:startDate];
    NSDate *d2 = [formatter dateFromString:[NSDate stringWithTime:endDate value:12 format:format]];
    NSTimeInterval start = [d1 timeIntervalSince1970]*1;
    NSTimeInterval end = [d2 timeIntervalSince1970]*1;
    NSTimeInterval value = start - end;
    if (value >= 0) {
        return NO;
    } else {
        return YES;
    }
}

+ (NSString *)stringWithTime:(NSString *)time value:(NSInteger)value format:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    formatter.dateFormat = format; //@"yyyy-MM";
    NSDate *date = [formatter dateFromString:time];
    NSCalendar *calendar = nil;
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        calendar = [NSCalendar currentCalendar];
    }
    NSDateComponents *dateComponents = [calendar components: NSCalendarUnitMonth fromDate:date];
    [dateComponents setMonth:-value];
    NSDate *newdate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    
    return [formatter stringFromDate:newdate];
}

// 使用NSDateFormatter转换时间字符串时，默认的时区是系统时区，如我们使用一般都是北京时间(＋8)

/**
 *  通过format格式将当前日期转换为String格式
 *
 *  @param format 格式样式
 *
 *  @return 转换后得到的String  yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)stringWithFormat:(NSString *)format timeStamp:(NSTimeInterval)stamp {
    stamp = stamp / 1000.0;
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:stamp]];
}

- (NSString *)dateWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

+ (BOOL)compareDateWithStartTimeStamp:(NSTimeInterval)startTimeStamp endTimeStamp:(NSTimeInterval)endTimeStamp {
    return NO;
//    NSDate *nowDate = [NSDate date];
//    NSDate *startDate = [[[NSDate dateWithTimeIntervalSince1970:startTimeStamp/1000] dateWithFormat:@"yyyy-MM-dd HH:mm:ss"] converToDate:@"yyyy-MM-dd HH:mm:ss"];
////    NSString *str = [NSDate stringWithFormat:@"yyyy-MM-dd" timeStamp:endTimeStamp];
////    NSDate *a = [str converToDate:@"yyyy-MM-dd"];
//    NSDate *endDate = [[NSDate stringWithFormat:@"yyyy-MM-dd HH:mm:ss" timeStamp:endTimeStamp] converToDate:@"yyyy-MM-dd HH:mm:ss"];
//    //[[[NSDate dateWithTimeIntervalSince1970:endTimeStamp/1000] dateWithFormat:@"yyyy-MM-dd"] converToDate:@"yyyy-MM-dd"];
//    if (([nowDate compare:startDate] == NSOrderedDescending || [nowDate compare:startDate] == NSOrderedSame) && ([nowDate compare:endDate] == NSOrderedAscending || [nowDate compare:endDate] == NSOrderedSame)) {
//        return YES;
//    } else {
//        return NO;
//    }
}

+ (BOOL)compareDateWithStartTimeString:(NSString *)startTimeString endTimeString:(NSString *)endTimeString {
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // 时间格式,此处遇到过坑,建议时间HH大写,手机24小时进制和12小时禁止都可以完美格式化
    [dateFormat setDateFormat:@"HH:mm"];
    NSString * todayStr=[dateFormat stringFromDate:today];//将日期转换成字符串
    today=[dateFormat dateFromString:todayStr];//转换成NSDate类型。日期置为方法默认日期
    //startTime格式为 02:22   expireTime格式为 12:44
    NSDate *start = [dateFormat dateFromString:startTimeString];
    NSDate *expire = [dateFormat dateFromString:endTimeString];
    
    if ([today compare:start] == NSOrderedDescending && [today compare:expire] == NSOrderedAscending) {
        return YES;
    }
    return NO;

}

+ (BOOL)compareTimeIntervalIsOutofTime:(long long)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *startTimeStr = [NSDate stringWithFormat:@"yyyy-MM-dd HH:mm:ss" timeStamp:time];
    NSDate *startDate =[formatter dateFromString:startTimeStr];
    
    NSDate *now = [NSDate date];
    NSString *nowstr = [formatter stringFromDate:now];
    NSDate *nowDate = [formatter dateFromString:nowstr];
    
    NSTimeInterval start = [startDate timeIntervalSince1970]*1;
    NSTimeInterval end = [nowDate timeIntervalSince1970]*1;
    NSTimeInterval value = 15*60 + 5 -(end - start);
    
    if (value > 0) {
        return false;
    }
    return true;
}


@end
