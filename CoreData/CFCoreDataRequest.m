//
//  CFCoreDataRequest.m
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2018/08/08.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CFCoreDataRequest.h"

@interface CFCoreDataRequest()

#pragma mark - property
//
// property
//
@property NSManagedObjectContext *objectContext;

@end



@implementation CFCoreDataRequest

#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self != nil)
    {
        [self setObjectContext:context];
    }
    return self;
}

// データ取得
- (NSArray *) requestWithEntityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns fetchLimit:(NSInteger)fetchLimit fetchOffset:(NSInteger)fetchOffset;
{
    // 座席Entityを取得
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self objectContext]];
    [request setEntity:entity];
    
    // 取得条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:whereQuery argumentArray:whereParameters];
    [request setPredicate:predicate];
    
    // ソート
    if (sortColumns != nil && [sortColumns count] > 0)
    {
        NSMutableArray *sortDescriptors = [NSMutableArray arrayWithCapacity:1];
        NSSortDescriptor *sort;
        for (NSDictionary *sortColumn in sortColumns)
        {
            for (NSString *keyString in sortColumn)
            {
                sort = [NSSortDescriptor sortDescriptorWithKey:keyString
                                                     ascending:[(NSNumber *)[sortColumn objectForKey:keyString] boolValue]
                        ];
                [sortDescriptors addObject:sort];
            }
        }
        [request setSortDescriptors:sortDescriptors];
    }
    
    // フェッチオフセット
    [request setFetchOffset:fetchOffset];
    
    // フェッチリミット
    if (fetchLimit > 0)
    {
        [request setFetchLimit:fetchLimit];
    }
    
    // 実取得
    NSError *error;
    NSArray *results = [[self objectContext] executeFetchRequest:request error:&error];
    
    // エラー
    if (error != nil)
    {
        NSLog(@"ERROR! CTCoreDataRequest.requestWithContext - %@",error);
        return nil;
    }
    else if ([results count] == 0)
    {
        return nil;
    }
    return results;
}

// データ取得(1件)
- (NSManagedObject *) objectWithEntityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [self objectWithEntityName:entityName whereQuery:whereQuery whereParameters:whereParameters sortColumns:nil];
}

// データ取得(1件)
- (NSManagedObject *) objectWithEntityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns
{
    NSArray *results = [self requestWithEntityName:entityName whereQuery:whereQuery whereParameters:whereParameters sortColumns:sortColumns fetchLimit:1 fetchOffset:0];
    if (results != nil)
    {
        return [results objectAtIndex:0];
    }
    return nil;
}

// データ取得(全件)
- (NSArray *) listWithEntityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns
{
    return [self requestWithEntityName:entityName whereQuery:whereQuery whereParameters:whereParameters sortColumns:sortColumns fetchLimit:0 fetchOffset:0];
}

// フェッチ取得
- (NSFetchedResultsController *) fetchWithEntityName:(NSString *)entityName sectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName refreshCache:(BOOL)refrechCache whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns
{
    if (whereParameters != nil && ([whereParameters isKindOfClass:[NSArray class]] == YES || [whereParameters isKindOfClass:[NSMutableArray class]] == YES) && [whereParameters count] == 0)
    {
        whereParameters = nil;
    }
    
    // 座席Entityを取得
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self objectContext]];
    [request setEntity:entity];
    
    // 取得条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:whereQuery argumentArray:whereParameters];
    [request setPredicate:predicate];
    
    // ソート
    if (sortColumns != nil && [sortColumns count] > 0)
    {
        NSMutableArray *sortDescriptors = [NSMutableArray arrayWithCapacity:1];
        NSSortDescriptor *sort;
        for (NSDictionary *sortColumn in sortColumns)
        {
            for (NSString *keyString in sortColumn)
            {
                sort = [NSSortDescriptor sortDescriptorWithKey:keyString ascending:[(NSNumber *)[sortColumn objectForKey:keyString] boolValue]];
                [sortDescriptors addObject:sort];
            }
        }
        [request setSortDescriptors:sortDescriptors];
    }
    
    // 実取得して返却
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[self objectContext] sectionNameKeyPath:sectionNameKeyPath cacheName:nil];
}

// count取得(1件)
- (NSNumber *) countWithEntityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [self numberFunctionWithEntityName:entityName functionName:@"count:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:nil];
}

// count取得(1件)(group by)
- (NSNumber *) countWithEntityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters groupby:(NSArray *)groupby
{
    return [self numberFunctionWithEntityName:entityName functionName:@"count:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:groupby];
}

// max取得(1件)
- (NSNumber *) maxWithEntityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [self numberFunctionWithEntityName:entityName functionName:@"max:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:nil];
}

// min取得(1件)
- (NSNumber *) minWithEntityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [self numberFunctionWithEntityName:entityName functionName:@"min:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:nil];
}

// average取得(1件)
- (NSNumber *) averageWithEntityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [self numberFunctionWithEntityName:entityName functionName:@"average:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:nil];
}

// sum取得(1件)
- (NSNumber *) sumWithEntityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [self numberFunctionWithEntityName:entityName functionName:@"sum:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:nil];
}



#pragma mark - private
//
// private
//

// 件数取得(1件)
- (NSNumber *) numberFunctionWithEntityName:(NSString *)entityName functionName:(NSString *)functionName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters groupby:(NSArray *)groupby
{
    // リクエスト
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // 取得用 Entity 生成
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self objectContext]];
    [request setEntity:entity];
    
    // expression
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:columnName];
    NSExpression *expression = [NSExpression expressionForFunction:functionName arguments:@[ keyPathExpression ]];
    // expression description
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:@"result"];
    [expressionDescription setExpression:expression];
    [expressionDescription setExpressionResultType:NSInteger16AttributeType];
    
    // result properties
    [request setResultType:NSDictionaryResultType];
    [request setPropertiesToFetch:[NSArray arrayWithObject:expressionDescription]];
    
    // groupby
    if (groupby != nil)
    {
        [request setPropertiesToGroupBy:groupby];
    }
    
    // 取得条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:whereQuery argumentArray:whereParameters];
    [request setPredicate:predicate];
    
    // データ取得
    NSError *error;
    NSArray *results = [[self objectContext] executeFetchRequest:request error:&error];
    
    // エラー
    if (error != nil)
    {
        NSLog(@"ERROR! CTCoreDataRequest.function - %@",error);
        return @0;
    }
    return [[results objectAtIndex:0] valueForKey:@"result"];
}

@end
