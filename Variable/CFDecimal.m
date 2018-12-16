//
//  CFDecimal.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFDecimal.h"

#import "CFEmptyVL.h"



@implementation CFDecimal

#pragma mark - method
//
// method
//

// NSDecimalNumberからフォーマット文字列を生成
+ (NSString *) formatWithDecimal:(NSDecimalNumber *)decimalValue
{
    return [self formatWithDecimal:decimalValue prefix:nil suffix:nil];
}

// NSDecimalNumberからフォーマット文字列を生成
+ (NSString *) formatWithDecimal:(NSDecimalNumber *)decimalValue scale:(int)scale
{
    return [self formatWithDecimal:decimalValue prefix:@"" suffix:@"" scale:scale];
}

// NSDecimalNumberからフォーマット文字列を生成
+ (NSString *) formatWithDecimal:(NSDecimalNumber *)decimalValue prefix:(NSString *)prefixString suffix:(NSString *)suffixString;
{
    static NSNumberFormatter *numberFormat;
    if(numberFormat == nil)
    {
        numberFormat = [[NSNumberFormatter alloc] init];
        [numberFormat setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormat setGroupingSeparator:@","];
        [numberFormat setGroupingSize:3];
    }
    prefixString = [CFEmptyVL compare:prefixString replace:@""];
    suffixString = [CFEmptyVL compare:suffixString replace:@""];
    
    [numberFormat setPositivePrefix:prefixString];
    [numberFormat setPositiveSuffix:suffixString];
    [numberFormat setNegativePrefix:[NSString stringWithFormat:@"-%@", prefixString]];
    [numberFormat setNegativeSuffix:suffixString];
    
    return [numberFormat stringForObjectValue:decimalValue];
}

// NSDecimalNumberからフォーマット文字列を生成
+ (NSString *) formatWithDecimal:(NSDecimalNumber *)decimalValue prefix:(NSString *)prefixString suffix:(NSString *)suffixString scale:(int)scale
{
    static NSNumberFormatter *numberFormat;
    if(numberFormat == nil)
    {
        numberFormat = [[NSNumberFormatter alloc] init];
        [numberFormat setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormat setGroupingSeparator:@","];
        [numberFormat setGroupingSize:3];
    }
    prefixString = [CFEmptyVL compare:prefixString replace:@""];
    suffixString = [CFEmptyVL compare:suffixString replace:@""];
    
    [numberFormat setPositivePrefix:prefixString];
    [numberFormat setPositiveSuffix:suffixString];
    [numberFormat setNegativePrefix:[NSString stringWithFormat:@"-%@", prefixString]];
    [numberFormat setNegativeSuffix:suffixString];
    
    [numberFormat setMinimumFractionDigits:scale];
    
    return [numberFormat stringForObjectValue:decimalValue];
}

// doubleからの変換
+ (NSDecimalNumber *) decimalWithDouble:(double)doubleValue
{
    return [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithDouble:doubleValue] decimalValue]];
}

// NSStringからの変換
+ (NSDecimalNumber *) decimalWithString:(NSString *)stringValue
{
    NSDecimalNumber *decimalValue = [NSDecimalNumber zero];
    @try
    {
        decimalValue = [NSDecimalNumber decimalNumberWithString:stringValue];
    }
    @catch (NSException *exception)
    {
        decimalValue = [self decimalWithDouble:[stringValue doubleValue]];
    }
    @finally {}
    return decimalValue;
}

@end
