//
//  CFCoreDataCondition.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/08/09.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFCoreDataCondition.h"

@implementation CFCoreDataCondition

#pragma mark - synthesize
//
// synthsize
//
@synthesize query;
@synthesize parameters;
@synthesize sorts;
@synthesize limit;
@synthesize offset;
@synthesize groupby;



#pragma mark - extends
//
// extends
//

// 初期化
- (instancetype) init
{
    return [self initWithQuery:@"" parameters:nil];
}



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithQuery:(NSString *)query parameters:(NSArray *)parameters
{
    return [self initWithQuery:query parameters:parameters sorts:nil];
}

// 初期化
- (instancetype) initWithQuery:(NSString *)query parameters:(NSArray *)parameters sorts:(NSArray *)sorts
{
    return [self initWithQuery:query parameters:parameters sorts:sorts limit:nil offset:nil];
}

// 初期化
- (instancetype) initWithQuery:(NSString *)query parameters:(NSArray *)parameters sorts:(NSArray *)sorts limit:(NSNumber *)limit offset:(NSNumber *)offset
{
    self = [super init];
    if (self != nil)
    {
        [self setQuery      :query];
        [self setParameters :parameters];
        [self setSorts      :sorts];
        [self setLimit      :limit];
        [self setOffset     :offset];
    }
    return self;
}

// 初期化
- (instancetype) initWithQuery:(NSString *)query parameters:(NSArray *)parameters groupby:(NSArray *)groupby
{
    self = [super init];
    if (self != nil)
    {
        [self setQuery      :query];
        [self setParameters :parameters];
        [self setGroupby    :groupby];
    }
    return self;
}

// NSSortDescriptor への変換
- (NSMutableArray<NSSortDescriptor *> *) convertSortDescriptors
{
    if ([self sorts] == nil)
    {
        return nil;
    }
    if ([[self sorts] count] == 0)
    {
        return nil;
    }
    
    //　ソート生成
    NSMutableArray<NSSortDescriptor *> *sortDescriptors = [@[] mutableCopy];
    for (NSDictionary *sortColumn in [self sorts])
    {
        NSString *sortKey = [[sortColumn allKeys] objectAtIndex:0];
        NSNumber *ascending = [[sortColumn allValues] objectAtIndex:0];
        
        [sortDescriptors addObject:[NSSortDescriptor sortDescriptorWithKey:sortKey ascending:[ascending boolValue]]];
    }
    return sortDescriptors;
}

@end
