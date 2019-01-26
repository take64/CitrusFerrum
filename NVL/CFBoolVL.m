//
//  CFBoolVL.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2019/01/26.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CFBoolVL.h"

@implementation CFBoolVL

// NVL BOOL関数
+ (id) compare:(BOOL)compare value1:(id)value1 value2:(id)value2
{
    if(compare == YES)
    {
        return value1;
    }
    return value2;
}

@end
