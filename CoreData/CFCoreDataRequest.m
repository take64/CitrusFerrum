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
@property NSString *entityName;

@end



@implementation CFCoreDataRequest

#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName
{
    self = [super init];
    if (self != nil)
    {
        [self setObjectContext:context];
        [self setEntityName:entityName];
    }
    return self;
}

// データ取得
- (NSArray *) requestWithWhereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns fetchLimit:(NSInteger)fetchLimit fetchOffset:(NSInteger)fetchOffset;
{
    // リクエスト生成
    NSFetchRequest *request = [self fetchRequestWithWhereQuery:whereQuery whereParameters:whereParameters];
    
    // ソート
    [request setSortDescriptors:[self sortDescriptorsWithColumns:sortColumns]];
    
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
- (NSManagedObject *) objectWithWhereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [self objectWithWhereQuery:whereQuery whereParameters:whereParameters sortColumns:nil];
}

// データ取得(1件)
- (NSManagedObject *) objectWithWhereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns
{
    NSArray *results = [self requestWithWhereQuery:whereQuery whereParameters:whereParameters sortColumns:sortColumns fetchLimit:1 fetchOffset:0];
    if (results != nil)
    {
        return [results objectAtIndex:0];
    }
    return nil;
}

// データ取得(全件)
- (NSArray *) listWithWhereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns
{
    return [self requestWithWhereQuery:whereQuery whereParameters:whereParameters sortColumns:sortColumns fetchLimit:0 fetchOffset:0];
}

// フェッチ取得
- (NSFetchedResultsController *) fetchWithSectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName refreshCache:(BOOL)refrechCache whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns
{
    if (whereParameters != nil && ([whereParameters isKindOfClass:[NSArray class]] == YES || [whereParameters isKindOfClass:[NSMutableArray class]] == YES) && [whereParameters count] == 0)
    {
        whereParameters = nil;
    }
    
    // リクエスト生成
    NSFetchRequest *request = [self fetchRequestWithWhereQuery:whereQuery whereParameters:whereParameters];
    
    // ソート
    [request setSortDescriptors:[self sortDescriptorsWithColumns:sortColumns]];
    
    // 実取得して返却
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[self objectContext] sectionNameKeyPath:sectionNameKeyPath cacheName:nil];
}

// count取得(1件)
- (NSNumber *) countWithColumnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [self numberFunctionWithFunctionName:@"count:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:nil];
}

// count取得(1件)(group by)
- (NSNumber *) countWithColumnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters groupby:(NSArray *)groupby
{
    return [self numberFunctionWithFunctionName:@"count:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:groupby];
}

// max取得(1件)
- (NSNumber *) maxWithColumnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [self numberFunctionWithFunctionName:@"max:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:nil];
}

// min取得(1件)
- (NSNumber *) minWithColumnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [self numberFunctionWithFunctionName:@"min:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:nil];
}

// average取得(1件)
- (NSNumber *) averageWithColumnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [self numberFunctionWithFunctionName:@"average:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:nil];
}

// sum取得(1件)
- (NSNumber *) sumWithColumnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    return [self numberFunctionWithFunctionName:@"sum:" columnName:columnName whereQuery:whereQuery whereParameters:whereParameters groupby:nil];
}



#pragma mark - private
//
// private
//

// 数値functionで取得(1件)
- (NSNumber *) numberFunctionWithFunctionName:(NSString *)functionName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters groupby:(NSArray *)groupby
{
    // リクエスト生成
    NSFetchRequest *request = [self fetchRequestWithWhereQuery:whereQuery whereParameters:whereParameters];
    
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

// NSFetchRequestの生成
- (NSFetchRequest *) fetchRequestWithWhereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters
{
    // リクエスト
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // 取得用 Entity 生成
    NSEntityDescription *entity = [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:[self objectContext]];
    [request setEntity:entity];
    
    // 取得条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:whereQuery argumentArray:whereParameters];
    [request setPredicate:predicate];
    
    return request;
}

// NSSortDescriptorの生成
- (NSMutableArray<NSSortDescriptor *> *) sortDescriptorsWithColumns:(NSArray *)sortColumns
{
    if (sortColumns == nil)
    {
        return nil;
    }
    if ([sortColumns count] == 0)
    {
        return nil;
    }
    
    //　ソート生成
    NSMutableArray<NSSortDescriptor *> *sortDescriptors = [@[] mutableCopy];
    for (NSDictionary *sortColumn in sortColumns)
    {
        NSString *sortKey = [[sortColumn allKeys] objectAtIndex:0];
        NSNumber *ascending = [[sortColumn allValues] objectAtIndex:0];
        
        [sortDescriptors addObject:[NSSortDescriptor sortDescriptorWithKey:sortKey ascending:ascending]];
    }
    return sortDescriptors;
}

@end
