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

#pragma mark - static public method
//
// static public method
//

// doubleからの変換
+ (NSDecimalNumber *) decimalWithDouble:(double)doubleValue
{
    return [NSDecimalNumber decimalNumberWithDecimal:[@(doubleValue) decimalValue]];
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

// NSNumberからの変換
+ (NSDecimalNumber *) decimalWithNumber:(NSNumber *)numberValue
{
    return [NSDecimalNumber decimalNumberWithDecimal:[numberValue decimalValue]];
}

// 比較して最大値を取得する
+ (NSDecimalNumber *) max:(NSDecimalNumber *)decimal1 with:(NSDecimalNumber *)decimal2
{
    if ([decimal1 compare:decimal2] == NSOrderedDescending)
    {
        return decimal1;
    }
    return decimal2;
}

// 比較して最小値を取得する
+ (NSDecimalNumber *) min:(NSDecimalNumber *)decimal1 with:(NSDecimalNumber *)decimal2
{
    if ([decimal1 compare:decimal2] == NSOrderedAscending)
    {
        return decimal1;
    }
    return decimal2;
}

// 最大値の取得
+ (NSDecimalNumber *) maxWidhList:(NSArray<NSDecimalNumber *> *)listValue
{
    NSDecimalNumber *result = [NSDecimalNumber minimumDecimalNumber];
    for (NSDecimalNumber *one in listValue)
    {
        if ([result compare:one] == NSOrderedAscending)
        {
            result = one;
        }
    }
    return result;
}

// 最小値の取得
+ (NSDecimalNumber *) minWidhList:(NSArray<NSDecimalNumber *> *)listValue
{
    NSDecimalNumber *result = [NSDecimalNumber maximumDecimalNumber];
    for (NSDecimalNumber *one in listValue)
    {
        if ([result compare:one] == NSOrderedDescending)
        {
            result = one;
        }
    }
    return result;
}

// 平均値の取得
+ (NSDecimalNumber *) avgWidhList:(NSArray<NSDecimalNumber *> *)listValue
{
    NSDecimalNumber *count = [NSDecimalNumber zero];
    NSDecimalNumber *total = [NSDecimalNumber zero];
    for (NSDecimalNumber *one in listValue)
    {
        count = [count decimalNumberByAdding:[NSDecimalNumber one]];
        total = [total decimalNumberByAdding:one];
    }
    if ([total compare:[NSDecimalNumber zero]] == NSOrderedSame)
    {
        return [NSDecimalNumber zero];
    }
    return [total decimalNumberByDividingBy:count];
}

@end
