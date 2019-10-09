//
//  CFDecimalRounding.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2019/10/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFDecimalRounding.h"

#import "CFEmptyVL.h"



@implementation CFDecimalRounding

#pragma mark - static public method
//
// static public method
//

// 切り上げ、切り捨て、四捨五入
+ (NSDecimalNumber *) decimalRoundingMode:(NSRoundingMode)roundingMode decimal:(NSDecimalNumber *)decimalValue scale:(NSUInteger)scale
{
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:scale raiseOnExactness:YES raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    return [decimalValue decimalNumberByRoundingAccordingToBehavior:handler];
}

// 切り上げ
+ (NSDecimalNumber *) decimalRoundUpWithDecimal:(NSDecimalNumber *) decimalValue
{
    return [self decimalRoundingMode:NSRoundUp decimal:decimalValue scale:0];
}

// 切り上げ
+ (NSDecimalNumber *) decimalRoundUpWithDecimal:(NSDecimalNumber *) decimalValue scale:(NSUInteger)scale
{
    return [self decimalRoundingMode:NSRoundUp decimal:decimalValue scale:scale];
}

// 切り捨て
+ (NSDecimalNumber *) decimalRoundDownWithDecimal:(NSDecimalNumber *) decimalValue
{
    return [self decimalRoundingMode:NSRoundDown decimal:decimalValue scale:0];
}

// 切り捨て
+ (NSDecimalNumber *) decimalRoundDownWithDecimal:(NSDecimalNumber *) decimalValue scale:(NSUInteger)scale
{
    return [self decimalRoundingMode:NSRoundDown decimal:decimalValue scale:scale];
}

// 四捨五入
+ (NSDecimalNumber *) decimalRoundPlainWithDecimal:(NSDecimalNumber *) decimalValue
{
    return [self decimalRoundingMode:NSRoundPlain decimal:decimalValue scale:0];
}

// 四捨五入
+ (NSDecimalNumber *) decimalRoundPlainWithDecimal:(NSDecimalNumber *) decimalValue scale:(NSUInteger)scale
{
    return [self decimalRoundingMode:NSRoundPlain decimal:decimalValue scale:scale];
}

@end
