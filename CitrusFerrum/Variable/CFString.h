//
//  CFString.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/08/28.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#endif

#define CFStringf(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

@interface CFString : NSObject

// URLエンコードする
+ (NSString *) urlEncodeWithString:(NSString *)stringValue;

// URLデコードする
+ (NSString *) urlDecodeWithString:(NSString *)stringValue;

// MD5ハッシュを取得する
+ (NSString *) md5WithString:(NSString *)stringValue;

// 数字から数字文字列に変更
+ (NSString *) stringWithInt:(NSInteger)intValue;

// 数字から数字文字列に変更
+ (NSString *) stringWithFloat:(float)floatValue;

// 数字から数字文字列に変更
+ (NSString *) stringWithLongLong:(long long)longLongValue;

// NSDecimalNumberからNSStringに変更
+ (NSString *) stringWithDecimal:(NSDecimalNumber *)decimalValue;

#if TARGET_OS_IOS
// サイズ取得
+ (CGSize) sizeWithString:(NSString *)stringValue font:(UIFont *)font constrainedToSize:(CGSize)constrainedToSize;
#endif

@end
