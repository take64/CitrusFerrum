//
//  CFCoreDataRequest.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/08/08.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CFCoreDataRequest.h"

#import "CFCoreDataCondition.h"

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
- (NSArray *) requestWithCondition:(CFCoreDataCondition * __nonnull)condition
{
    // リクエスト生成
    NSFetchRequest *request = [self fetchRequestWithWhereQuery:[condition query] whereParameters:[condition parameters]];
    
    // ソート
    [request setSortDescriptors:[condition convertSortDescriptors]];
    
    // フェッチリミット
    if ([condition limit] != nil)
    {
        [request setFetchLimit:[[condition limit] integerValue]];
    }
    
    // フェッチオフセット
    [request setFetchOffset:[[condition offset] integerValue]];
    
    
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
- (NSManagedObject *) objectWithCondition:(CFCoreDataCondition * __nonnull)condition
{
    [condition setLimit:@1];
    [condition setOffset:@0];
    NSArray *results = [self requestWithCondition:condition];
    if (results != nil)
    {
        return [results objectAtIndex:0];
    }
    return nil;
}

// データ取得(全件)
- (NSArray *) listWithCondition:(CFCoreDataCondition * __nonnull)condition
{
    return [self requestWithCondition:condition];
}

// フェッチ取得
- (NSFetchedResultsController *) fetchWithSectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName refreshCache:(BOOL)refrechCache condition:(CFCoreDataCondition * __nonnull)condition
{
    // リクエスト生成
    NSFetchRequest *request = [self fetchRequestWithWhereQuery:[condition query] whereParameters:[condition parameters]];
    
    // ソート
    [request setSortDescriptors:[condition convertSortDescriptors]];
    
    // 実取得して返却
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[self objectContext] sectionNameKeyPath:sectionNameKeyPath cacheName:cacheName];
}

// count取得(1件)
- (NSNumber *) countWithColumnName:(NSString *)columnName condition:(CFCoreDataCondition * __nonnull)condition
{
    return [self numberFunctionWithFunctionName:@"count:" columnName:columnName condiion:condition];
}

// max取得(1件)
- (NSNumber *) maxWithColumnName:(NSString *)columnName condition:(CFCoreDataCondition * __nonnull)condition
{
    return [self numberFunctionWithFunctionName:@"max:" columnName:columnName condiion:condition];
}

// min取得(1件)
- (NSNumber *) minWithColumnName:(NSString *)columnName condition:(CFCoreDataCondition * __nonnull)condition
{
    return [self numberFunctionWithFunctionName:@"min:" columnName:columnName condiion:condition];
}

// average取得(1件)
- (NSNumber *) averageWithColumnName:(NSString *)columnName condition:(CFCoreDataCondition * __nonnull)condition
{
    return [self numberFunctionWithFunctionName:@"average:" columnName:columnName condiion:condition];
}

// sum取得(1件)
- (NSNumber *) sumWithColumnName:(NSString *)columnName condition:(CFCoreDataCondition * __nonnull)condition
{
    return [self numberFunctionWithFunctionName:@"sum:" columnName:columnName condiion:condition];
}



#pragma mark - private
//
// private
//

// 数値functionで取得(1件)
- (NSNumber *) numberFunctionWithFunctionName:(NSString *)functionName columnName:(NSString *)columnName condiion:(CFCoreDataCondition * __nonnull)condition
{
    // リクエスト生成
    NSFetchRequest *request = [self fetchRequestWithWhereQuery:[condition query] whereParameters:[condition parameters]];
    
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
    if ([condition groupby] != nil)
    {
        [request setPropertiesToGroupBy:[condition groupby]];
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

@end
