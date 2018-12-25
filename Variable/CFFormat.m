//
//  CFFormat.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/26.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFFormat.h"

@implementation CFFormat

#pragma mark - static method
//
// static method
//

// NSDecimalNumberからフォーマット文字列を生成
+ (NSString *) formatWithDecimal:(NSDecimalNumber *)decimalValue
{
    return [self formatWithDecimal:decimalValue prefix:nil suffix:nil];
}

// NSDecimalNumberからフォーマット文字列を生成
+ (NSString *) formatWithDecimal:(NSDecimalNumber *)decimalValue scale:(NSUInteger)scale
{
    return [self formatWithDecimal:decimalValue prefix:@"" suffix:@"" scale:scale];
}

// NSDecimalNumberからフォーマット文字列を生成
+ (NSString *) formatWithDecimal:(NSDecimalNumber *)decimalValue prefix:(NSString *)prefixString suffix:(NSString *)suffixString;
{
    return [self formatWithDecimal:decimalValue prefix:prefixString suffix:suffixString scale:kDecimalNoneScale];
}

// NSDecimalNumberからフォーマット文字列を生成
+ (NSString *) formatWithDecimal:(NSDecimalNumber *)decimalValue prefix:(NSString *)prefixString suffix:(NSString *)suffixString scale:(NSUInteger)scale
{
    static NSNumberFormatter *numberFormat;
    if (numberFormat == nil)
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
    
    if (scale != kDecimalNoneScale)
    {
        [numberFormat setMinimumFractionDigits:scale];
    }
    
    return [numberFormat stringForObjectValue:decimalValue];
}

@end
