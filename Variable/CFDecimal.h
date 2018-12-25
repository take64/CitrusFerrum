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

// doubleからの変換
+ (NSDecimalNumber *) decimalWithDouble:(double)doubleValue;

// NSStringからの変換
+ (NSDecimalNumber *) decimalWithString:(NSString *)stringValue;

// NSNumberからの変換
+ (NSDecimalNumber *) decimalWithNumber:(NSNumber *)numberValue;

// 比較して最大値を取得する
+ (NSDecimalNumber *) max:(NSDecimalNumber *)decimal1 with:(NSDecimalNumber *)decimal2;

// 比較して最小値を取得する
+ (NSDecimalNumber *) min:(NSDecimalNumber *)decimal1 with:(NSDecimalNumber *)decimal2;

// 最大値の取得
+ (NSDecimalNumber *) maxWidhList:(NSArray<NSDecimalNumber *> *)listValue;

// 最小値の取得
+ (NSDecimalNumber *) minWidhList:(NSArray<NSDecimalNumber *> *)listValue;

// 平均値の取得
+ (NSDecimalNumber *) avgWidhList:(NSArray<NSDecimalNumber *> *)listValue;

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
