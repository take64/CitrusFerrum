//
//  CFDecimalRounding.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2019/10/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFDecimalRounding : NSObject

//
// static public method
//

// 切り上げ、切り捨て、四捨五入
+ (NSDecimalNumber *) decimalRoundingMode:(NSRoundingMode)roundingMode decimal:(NSDecimalNumber *)decimalValue scale:(NSUInteger)scale;

// 切り上げ
+ (NSDecimalNumber *) decimalRoundUpWithDecimal:(NSDecimalNumber *) decimalValue;

// 切り上げ
+ (NSDecimalNumber *) decimalRoundUpWithDecimal:(NSDecimalNumber *) decimalValue scale:(NSUInteger)scale;

// 切り捨て
+ (NSDecimalNumber *) decimalRoundDownWithDecimal:(NSDecimalNumber *) decimalValue;

// 切り捨て
+ (NSDecimalNumber *) decimalRoundDownWithDecimal:(NSDecimalNumber *) decimalValue scale:(NSUInteger)scale;

// 四捨五入
+ (NSDecimalNumber *) decimalRoundPlainWithDecimal:(NSDecimalNumber *) decimalValue;

// 四捨五入
+ (NSDecimalNumber *) decimalRoundPlainWithDecimal:(NSDecimalNumber *) decimalValue scale:(NSUInteger)scale;

@end
