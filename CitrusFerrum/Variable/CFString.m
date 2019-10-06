//
//  CFString.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/08/28.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFString.h"

#import <CommonCrypto/CommonCrypto.h>

@implementation CFString

#pragma mark - static
//
// static
//

// URLエンコードする
+ (NSString *) urlEncodeWithString:(NSString *)stringValue
{
    return [stringValue stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

// URLデコードする
+ (NSString *) urlDecodeWithString:(NSString *)stringValue
{
    return [stringValue stringByRemovingPercentEncoding];
}

// MD5ハッシュを取得する
+ (NSString *) md5WithString:(NSString *)stringValue
{
    NSData *dataValue = [stringValue dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5([dataValue bytes], (CC_LONG)[dataValue length], digest);
    char md5cstring[CC_MD5_DIGEST_LENGTH*2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        sprintf(md5cstring+i*2, "%02x", digest[i]);
    }
    
    return [NSString stringWithCString:md5cstring encoding:NSUTF8StringEncoding];
}

// 数字から数字文字列に変更
+ (NSString *) stringWithInt:(NSInteger)intValue
{
    return [NSString stringWithFormat:@"%ld", (long)intValue];
}

// 数字から数字文字列に変更
+ (NSString *) stringWithFloat:(float)floatValue
{
    return [NSString stringWithFormat:@"%f", floatValue];
}

// 数字から数字文字列に変更
+ (NSString *) stringWithLongLong:(long long)longLongValue
{
    return [NSString stringWithFormat:@"%lld", longLongValue];
}

// NSDecimalNumberからNSStringに変更
+ (NSString *) stringWithDecimal:(NSDecimalNumber *)decimalValue
{
    NSString *stringValue = @"0";
    @try
    {
        stringValue = [decimalValue stringValue];
    }
    @catch (NSException *exception)
    {
        stringValue = [NSString stringWithFormat:@"%@", decimalValue];
    }
    @finally { }
    return stringValue;
}

#if TARGET_OS_IOS
// サイズ取得
+ (CGSize) sizeWithString:(NSString *)stringValue font:(UIFont *)font constrainedToSize:(CGSize)constrainedToSize
{
    // パラグラフ
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraph setAlignment:NSTextAlignmentLeft];
    // 文字列要素
    NSMutableDictionary *attributes = [@{} mutableCopy];
    [attributes addEntriesFromDictionary:@{
                                           NSParagraphStyleAttributeName:paragraph,
                                           NSFontAttributeName          :font,
                                           }];
    
    NSStringDrawingOptions options = (NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine);
    CGSize size = [stringValue boundingRectWithSize:constrainedToSize options:options attributes:attributes context:nil].size;
    
    size.height = ceil(size.height);
    size.width = ceil(size.width);
    
    return size;
}
#endif

@end
