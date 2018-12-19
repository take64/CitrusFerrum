//
//  CFArray.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/20.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFArray.h"



@implementation CFArray

#pragma mark - static method

//
// static method
//

// 配列内に一致する文字列があるか？
+ (BOOL) inString:(NSString *)needle array:(NSArray<NSString *> *)heystacks
{
    for (NSString *heystack in heystacks)
    {
        if ([needle isEqualToString:heystack] == YES)
        {
            return YES;
        }
    }
    return NO;
}

@end
