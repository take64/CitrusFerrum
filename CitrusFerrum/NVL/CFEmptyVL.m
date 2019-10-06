//
//  CFEmptyVL.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/16.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFEmptyVL.h"

@implementation CFEmptyVL

#pragma mark - method
//
// method
//

// NVL関数
+ (id) compare:(id)compare replace:(id)replace
{
    return [self compare:compare value1:compare value2:replace];
}

// NVL2関数
+ (id) compare:(id)compare value1:(id)value1 value2:(id)value2
{
    BOOL isEmpty = NO;

    if (compare == nil)
    {
        isEmpty = YES;
    }
    // NSString
    else if ([compare isKindOfClass:[NSString class]] == YES)
    {
        isEmpty = ([(NSString *)compare isEqualToString:@""] == YES);
    }
    // NSNumber
    else if ([compare isKindOfClass:[NSNumber class]] == YES)
    {
        isEmpty = ([(NSNumber *)compare compare:@0] == NSOrderedSame);
    }
    // NSDecimalNumber
    else if ([compare isKindOfClass:[NSDecimalNumber class]] == YES)
    {
        isEmpty = ([(NSDecimalNumber *)compare compare:[NSDecimalNumber zero]] == NSOrderedSame);
    }

    // return
    return (isEmpty == YES ? value2 : value1);
}

@end
