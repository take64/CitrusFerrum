//
//  CTDate.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFDate.h"

#import <mach/mach_time.h>
#import <time.h>
#import <sqlite3.h>

@implementation CFDate

// 日付フォーマットを自動識別して取得
+ (NSDate *) dateWithString:(NSString *)stringValue
{
    sqlite3 *db = NULL;
    sqlite3_open(":memory:", &db);
    sqlite3_stmt *statement = NULL;
    sqlite3_prepare_v2(db, "SELECT strftime('%s', ?);", -1, &statement, NULL);

    sqlite3_bind_text(statement, 1, stringValue.UTF8String, -1, SQLITE_STATIC);
    sqlite3_step(statement);
    sqlite3_int64 timestamp = sqlite3_column_int64(statement, 0);

    NSDate *dateValue = [NSDate dateWithTimeIntervalSince1970:timestamp];

    sqlite3_clear_bindings(statement);
    sqlite3_reset(statement);

    return dateValue;
}

// 日付フォーマットからNSDateを取得
+ (NSDate *) dateWithString:(NSString *)stringValue format:(NSString *)formatString
{
    return [self dateWithString:stringValue format:formatString locale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
}

// 日付フォーマットからNSDateを取得(LOCALE指定)
+ (NSDate *) dateWithString:(NSString *)stringValue format:(NSString *)formatString locale:(NSLocale *)localeValue
{
    return [self dateWithString:stringValue format:formatString locale:localeValue timeZone:[NSTimeZone defaultTimeZone]];
}

// 日付フォーマットからNSDateを取得(LOCALE指定/タイムゾーン指定)
+ (NSDate *) dateWithString:(NSString *)stringValue format:(NSString *)formatString locale:(NSLocale *)localeValue timeZone:(NSTimeZone *)timeZoneValue
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:localeValue];
    [formatter setTimeZone:timeZoneValue];
    [formatter setDateFormat:formatString];
    NSDate *date = [formatter dateFromString:stringValue];

    return date;
}

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

// タイムスタンプ文字列からNSDateに
+ (NSDate *) dateWithUnixTimeString:(NSString *)stringValue
{
    return [NSDate dateWithTimeIntervalSince1970:[stringValue intValue]];
}

// 日付から時分秒をとる
+ (NSDate *) dateRemoveHHIISSWithDate:(NSDate *)dateValue
{
    return [self dateRemoveHHIISSWithDate:dateValue locale:[NSLocale currentLocale]];
}

// 日付から時分秒をとる
+ (NSDate *) dateRemoveHHIISSWithDate:(NSDate *)dateValue locale:(NSLocale *)localeValue
{
    return [self dateRemoveHHIISSWithDate:dateValue locale:localeValue timeZone:[NSTimeZone defaultTimeZone]];
}

// 日付から時分秒をとる
+ (NSDate *) dateRemoveHHIISSWithDate:(NSDate *)dateValue locale:(NSLocale *)localeValue timeZone:(NSTimeZone *)timeZoneValue
{
    NSCalendar *calendar = [self callCalendar];
    NSDateComponents *components = [self componentsWithDate:dateValue];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];

    return [calendar dateFromComponents:components];
}

// 本日日付
+ (NSDate *) todayDate
{
    NSCalendar *calendar = [self callCalendar];
    NSDateComponents *components = [self componentsWithDate:[NSDate date]];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];

    return [calendar dateFromComponents:components];
}

// 日付から年を取得
+ (NSInteger) yearWithDate:(NSDate *)dateValue
{
    return [[self componentsWithDate:dateValue] year];
}

// 日付から月を取得
+ (NSInteger) monthWithDate:(NSDate *)dateValue
{
    return [[self componentsWithDate:dateValue] month];
}

// 日付から日を取得
+ (NSInteger)dayWithDate:(NSDate *)dateValue
{
    return [[self componentsWithDate:dateValue] day];
}

// 月の初めを取得
+ (NSDate *) monthFirstWithDate:(NSDate *)dateValue
{
    NSCalendar *calendar = [self callCalendar];
    NSDateComponents *components = [self componentsWithDate:dateValue];
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];

    return [calendar dateFromComponents:components];
}

// コンポーネントの取得
+ (NSDateComponents *) componentsWithDate:(NSDate *)dateValue
{
    NSCalendar *calendar = [self callCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday) fromDate:dateValue];

    return components;
}

// コンポーネントから日付を取得
+ (NSDate *) dateWithComponents:(NSDateComponents *)componentsValue
{
    return [[self callCalendar] dateFromComponents:componentsValue];
}

// 日付の取得
+ (NSDate *) dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    return [[self callCalendar] dateWithEra:1 year:year month:month day:day hour:hour minute:minute second:second nanosecond:0];
}

// カレンダーの取得
+ (NSCalendar *) callCalendar
{
    static NSCalendar *calendar;
    if (calendar == nil)
    {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [calendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
        [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return calendar;
}

// 前月の月初めを取得
+ (NSDate *) prevMonthFirstDateWithDate:(NSDate *)dateValue
{
    NSDateComponents *components = [CFDate componentsWithDate:dateValue];
    return [self dateWithYear:[components year] month:[components month] - 1 day:1 hour:0 minute:0 second:0];
}

// 翌月の月初めを取得
+ (NSDate *) nextMonthFirstDateWithDate:(NSDate *)dateValue
{
    NSDateComponents *components = [CFDate componentsWithDate:dateValue];
    return [self dateWithYear:[components year] month:[components month] + 1 day:1 hour:0 minute:0 second:0];
}

@end
