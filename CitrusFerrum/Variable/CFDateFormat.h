//
//  CFDateFormat.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2019/10/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFDateFormat : NSObject

//
// static public method
//

// 日付フォーマットされた文字列を取得
+ (NSString *) stringWithDate:(NSDate *)dateValue format:(NSString *)formatString;

// 日付フォーマットされた文字列を取得(LOCALE指定)
+ (NSString *) stringWithDate:(NSDate *)dateValue format:(NSString *)formatString locale:(NSLocale *)localeValue;

// 日付フォーマットされた文字列を取得(LOCALE指定/タイムゾーン指定)
+ (NSString *) stringWithDate:(NSDate *)dateValue format:(NSString *)formatString locale:(NSLocale *)localeValue timeZone:(NSTimeZone *)timeZoneValue;

// タイムスタンプ文字列
+ (NSString *) stringUnixTime:(NSDate *)dateValue;

@end
