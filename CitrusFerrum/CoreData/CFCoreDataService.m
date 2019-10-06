//
//  CFCoreDataService.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/20.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFCoreDataService.h"

#import <CoreData/CoreData.h>

#import "CFArray.h"
#import "CFElement.h"
#import "CFNVL.h"



@implementation CFCoreDataService

#pragma mark - static method
//
// static method
//

// レコードのデータをDictionaryで取得
+ (NSDictionary *) dictionaryWithEntity:(NSManagedObject *)entityValue
{
    NSArray *keyList = [[[entityValue entity] attributesByName] allKeys];
    NSMutableDictionary *data = [@{} mutableCopy];
    for (NSString *keyString in keyList)
    {
        id valueData = [entityValue valueForKey:keyString];
        if ([valueData isKindOfClass:[NSString class]] == YES)
        {
            [data setObject:[CFNVL compare:valueData replace:@""] forKey:keyString];
        }
        else if ([valueData isKindOfClass:[NSNumber class]] == YES)
        {
            [data setObject:[CFNVL compare:valueData replace:@0] forKey:keyString];
        }
        else if ([valueData isKindOfClass:[NSDecimalNumber class]] == YES)
        {
            [data setObject:[CFNVL compare:valueData replace:[NSDecimalNumber zero]] forKey:keyString];
        }
        else if ([valueData isKindOfClass:[NSDate class]] == YES)
        {
            [data setObject:[CFNVL compare:valueData replace:[NSDate dateWithTimeIntervalSince1970:0]] forKey:keyString];
        }
        else if ([valueData isKindOfClass:[NSData class]] == YES)
        {
            [data setObject:[CFNVL compare:valueData replace:[NSData data]] forKey:keyString];
        }
    }
    return [data copy];
}

// ObjectデータをEntityにbindする
+ (NSManagedObject *) bindEntity:(NSManagedObject *)entityValue fromObject:(CFElement *)elementValue
{
    NSArray *keyList = [[[entityValue entity] attributesByName] allKeys];
    for (NSString *keyString in keyList)
    {
        // カラムによってはスルーする
        if ([CFArray inString:keyString array:@[ @"status", @"created", @"modified" ]] == YES)
        {
            continue;
        }
        
        // 指定カラムでプロパティを取得できる
        if ([elementValue respondsToSelector:NSSelectorFromString(keyString)] == YES
                && [elementValue valueForKey:keyString] != nil)
        {
            [entityValue setValue:[elementValue valueForKey:keyString] forKey:keyString];
        }
    }
    
    return entityValue;
}

// リクエスト
+ (CFCoreDataRequest *) callRequest
{
    return nil;
}

@end
