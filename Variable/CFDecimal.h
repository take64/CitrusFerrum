//
//  CFDecimal.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFDecimal : NSObject

//
// static method
//

// NSDecimalNumberからフォーマット文字列を作成
+ (NSString *) formatWithDecimal:(NSDecimalNumber *)decimalValue;

// NSDecimalNumberからフォーマット文字列を生成
+ (NSString *) formatWithDecimal:(NSDecimalNumber *)decimalValue scale:(NSUInteger)scale;

// NSDecimalNumberからフォーマット文字列を作成
+ (NSString *) formatWithDecimal:(NSDecimalNumber *)decimalValue prefix:(NSString *)prefixString suffix:(NSString *)suffixString;

// NSDecimalNumberからフォーマット文字列を生成
+ (NSString *) formatWithDecimal:(NSDecimalNumber *)decimalValue prefix:(NSString *)prefixString suffix:(NSString *)suffixString scale:(NSUInteger)scale;

// doubleからの変換
+ (NSDecimalNumber *) decimalWithDouble:(double)doubleValue;

// NSStringからの変換
+ (NSDecimalNumber *) decimalWithString:(NSString *)stringValue;

@end
