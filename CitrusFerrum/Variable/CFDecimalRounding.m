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
+ (NSDecimalNumber *) roundingMode:(NSRoundingMode)roundingMode decimal:(NSDecimalNumber *)decimalValue scale:(NSUInteger)scale
{
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:scale raiseOnExactness:YES raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    return [decimalValue decimalNumberByRoundingAccordingToBehavior:handler];
}

// 切り上げ
+ (NSDecimalNumber *) upWithDecimal:(NSDecimalNumber *) decimalValue
{
    return [self roundingMode:NSRoundUp decimal:decimalValue scale:0];
}

// 切り上げ
+ (NSDecimalNumber *) upWithDecimal:(NSDecimalNumber *) decimalValue scale:(NSUInteger)scale
{
    return [self roundingMode:NSRoundUp decimal:decimalValue scale:scale];
}

// 切り捨て
+ (NSDecimalNumber *) downWithDecimal:(NSDecimalNumber *) decimalValue
{
    return [self roundingMode:NSRoundDown decimal:decimalValue scale:0];
}

// 切り捨て
+ (NSDecimalNumber *) downWithDecimal:(NSDecimalNumber *) decimalValue scale:(NSUInteger)scale
{
    return [self roundingMode:NSRoundDown decimal:decimalValue scale:scale];
}

// 四捨五入
+ (NSDecimalNumber *) plainWithDecimal:(NSDecimalNumber *) decimalValue
{
    return [self roundingMode:NSRoundPlain decimal:decimalValue scale:0];
}

// 四捨五入
+ (NSDecimalNumber *) plainWithDecimal:(NSDecimalNumber *) decimalValue scale:(NSUInteger)scale
{
    return [self roundingMode:NSRoundPlain decimal:decimalValue scale:scale];
}

@end
