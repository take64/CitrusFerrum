//
//  CFBusiness.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/22.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFBusiness.h"

#import "CFDate.h"
#import "CFDateFormat.h"
#import "CFString.h"



@implementation CFBusiness

#pragma mark - static method
//
// static method
//

// entity用ユニークID
+ (NSString *) uniqueID
{
    return [self uniqueIDSeed1:[CFString md5WithString:CFStringf(@"%d", rand())]
                         seed2:[CFString md5WithString:CFStringf(@"%f", [[NSDate date] timeIntervalSince1970])]];
}

// entity用ユニークID
+ (NSString *) uniqueIDSeed1:(NSString *)seed1 seed2:(NSString *)seed2
{
    NSString *half01 = [CFString md5WithString:seed1];
    NSString *half02 = [CFString md5WithString:seed2];
    return CFStringf(@"%@%@", half01, half02);
}

// entity配列のdictionary配列化
+ (NSArray *) dictionariesWithEntities:(NSArray *)entities
{
    if (entities == nil || [entities count] == 0)
    {
        return @[];
    }
    
    // entity
    NSManagedObject *firstEntity = [entities firstObject];
    // カラム名リスト
    NSDictionary *columns = [[firstEntity entity] attributesByName];
    // 返却値
    NSMutableArray *results = [NSMutableArray array];
    
    // 変換
    for (NSManagedObject *entity in entities)
    {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        for (NSString *column in [columns allKeys])
        {
            // category項目はスルー
            NSAttributeDescription *attributeDescription = columns[column];
            if ([attributeDescription isTransient] == YES)
            {
                continue;
            }
            
            id value = [entity valueForKey:column];
            if (value == nil)
            {
                value = [NSNull null];
            }
            else if ([value isKindOfClass:[NSDate class]] == YES)
            {
                value = [CFDateFormat stringWithDate:value format:@"yyyyMMddHHmmss"];
            }
            [result setObject:value forKey:column];
        }
        [results addObject:result];
    }
    
    return [results copy];
}

// dictionary配列からentityに変換
+ (NSManagedObject *) entityWithEntity:(NSManagedObject *)entityValue withDictionary:(NSDictionary *)dicValue
{
    if (dicValue == nil)
    {
        return entityValue;
    }
    
    // カラム名リスト
    NSDictionary *columns = [[entityValue entity] propertiesByName];
    for (NSString *column in columns)
    {
        NSPropertyDescription *property = [columns objectForKey:column];
        if ([property isKindOfClass:[NSAttributeDescription class]] == NO)
        {
            continue;
        }
        if ([(NSAttributeDescription *)property isTransient] == YES)
        {
            continue;
        }
        
        NSString *className = [(NSAttributeDescription *)property attributeValueClassName];
        id value = [dicValue objectForKey:column];
        if ([value isEqual:[NSNull null]] == YES)
        {
            continue;
        }
        if ([className isEqualToString:@"NSDate"] == YES)
        {
            value = [CFDate dateWithString:value format:@"yyyyMMddHHmmss"];
        }
        [entityValue setValue:value forKey:column];
    }
    return entityValue;
}

@end
