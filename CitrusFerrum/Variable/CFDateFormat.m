//
//  CFDateFormat.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2019/10/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFDateFormat.h"

#import <mach/mach_time.h>
#import <time.h>
#import <sqlite3.h>

@implementation CFDateFormat

#pragma mark - static public method
//
// static public method
//

// 日付フォーマットされた文字列を取得
+ (NSString *) stringWithDate:(NSDate *)dateValue format:(NSString *)formatString
{
    return [self stringWithDate:dateValue format:formatString locale:[NSLocale currentLocale]];
}

// 日付フォーマットされた文字列を取得(LOCALE指定)
+ (NSString *) stringWithDate:(NSDate *)dateValue format:(NSString *)formatString locale:(NSLocale *)localeValue
{
    return [self stringWithDate:dateValue format:formatString locale:localeValue timeZone:[NSTimeZone defaultTimeZone]];
}

// 日付フォーマットされた文字列を取得(LOCALE指定/タイムゾーン指定)
+ (NSString *) stringWithDate:(NSDate *)dateValue format:(NSString *)formatString locale:(NSLocale *)localeValue timeZone:(NSTimeZone *)timeZoneValue
{
    // フォーマット
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZoneValue];
    [formatter setLocale:localeValue];
    [formatter setDateFormat:formatString];

    // 変換
    return [formatter stringFromDate:dateValue];
}

// タイムスタンプ文字列
+ (NSString *) stringUnixTime:(NSDate *)dateValue
{
    return [NSString stringWithFormat:@"%f", [dateValue timeIntervalSince1970]];
}

@end
