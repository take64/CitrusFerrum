//
//  CFNVL.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFNVL.h"

@implementation CFNVL

#pragma mark - static method
//
// static method
//

// NVL関数
+ (id) compare:(id)compare replace:(id)replace
{
    if(compare == nil || [compare isEqual:[NSNull null]] == YES)
    {
        return replace;
    }
    return compare;
}

// NVL2関数
+ (id) compare:(id)compare value1:(id)value1 value2:(id)value2
{
    if(compare == nil || [compare isEqual:[NSNull null]] == YES)
    {
        return value2;
    }
    return value1;
}

@end
