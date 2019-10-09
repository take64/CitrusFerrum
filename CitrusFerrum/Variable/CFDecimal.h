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
// static public method
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

@end
