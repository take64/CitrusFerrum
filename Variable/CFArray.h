//
//  CFArray.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/20.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^CitrusFerrumArrayCallback)(id one);

@interface CFArray : NSObject

//
// static method
//

// 配列内に一致する文字列があるか？
+ (BOOL) inString:(NSString *)needle array:(NSArray<NSString *> *)heystacks;

// 配列を利用してコールバックで配列を生成する
+ (NSArray *) filter:(NSArray *)list callback:(CitrusFerrumArrayCallback)callback;

@end
