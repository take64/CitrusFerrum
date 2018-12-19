//
//  CFArray.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/20.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFArray : NSObject

//
// static method
//

// 配列内に一致する文字列があるか？
+ (BOOL) inString:(NSString *)needle array:(NSArray<NSString *> *)heystacks;

@end
