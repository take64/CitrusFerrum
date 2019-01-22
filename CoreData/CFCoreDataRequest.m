//
//  CFCoreDataRequest.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/08/08.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFCoreDataRequest.h"

#import "CFCoreDataCondition.h"



#pragma mark - static variables
//
// static variables
//
static NSString * const kFunctionCount  = @"count:";
static NSString * const kFunctionMax    = @"max:";
static NSString * const kFunctionMin    = @"min:";
static NSString * const kFunctionAverage= @"average:";
static NSString * const kFunctionSum    = @"sum:";



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
    NSFetchRequest *request = [self fetchRequestWithCondition:condition];
    
    // 実取得
    NSError *error;
    NSArray *results = [[self objectContext] executeFetchRequest:request error:&error];
    
    // エラー
    if (error != nil)
    {
        NSLog(@"ERROR! CFCoreDataRequest.requestWithContext - %@",error);
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
    NSFetchRequest *request = [self fetchRequestWithCondition:condition];
    
    // キャッシュの削除
    if (refrechCache == YES)
    {
        [NSFetchedResultsController deleteCacheWithName:cacheName];
    }
    
    // 実取得して返却
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[self objectContext] sectionNameKeyPath:sectionNameKeyPath cacheName:cacheName];
}

// count取得(1件)
- (NSNumber *) countWithColumnName:(NSString *)columnName condition:(CFCoreDataCondition * __nonnull)condition
{
    return [self numberFunctionWithFunctionName:kFunctionCount columnName:columnName condition:condition];
}

// max取得(1件)
- (NSNumber *) maxWithColumnName:(NSString *)columnName condition:(CFCoreDataCondition * __nonnull)condition
{
    return [self numberFunctionWithFunctionName:kFunctionMax columnName:columnName condition:condition];
}

// min取得(1件)
- (NSNumber *) minWithColumnName:(NSString *)columnName condition:(CFCoreDataCondition * __nonnull)condition
{
    return [self numberFunctionWithFunctionName:kFunctionMin columnName:columnName condition:condition];
}

// average取得(1件)
- (NSNumber *) averageWithColumnName:(NSString *)columnName condition:(CFCoreDataCondition * __nonnull)condition
{
    return [self numberFunctionWithFunctionName:kFunctionAverage columnName:columnName condition:condition];
}

// sum取得(1件)
- (NSNumber *) sumWithColumnName:(NSString *)columnName condition:(CFCoreDataCondition * __nonnull)condition
{
    return [self numberFunctionWithFunctionName:kFunctionSum columnName:columnName condition:condition];
}



#pragma mark - private
//
// private
//

// 数値functionで取得(1件)
- (NSNumber *) numberFunctionWithFunctionName:(NSString *)functionName columnName:(NSString *)columnName condition:(CFCoreDataCondition * __nonnull)condition
{
    // リクエスト生成
    NSFetchRequest *request = [self fetchRequestWithCondition:condition];
    
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
    [request setPropertiesToFetch:@[ expressionDescription ]];
    
    // データ取得
    NSError *error;
    NSArray *results = [[self objectContext] executeFetchRequest:request error:&error];
    
    // エラー
    if (error != nil)
    {
        NSLog(@"ERROR! CFCoreDataRequest.function - %@",error);
        return @0;
    }
    return [[results objectAtIndex:0] valueForKey:@"result"];
}

// NSFetchRequestの生成
- (NSFetchRequest *) fetchRequestWithCondition:(CFCoreDataCondition * __nonnull)condition
{
    // リクエスト
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    // 取得用 Entity 生成
    NSEntityDescription *entity = [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:[self objectContext]];
    [request setEntity:entity];
    
    // 取得条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[condition query] argumentArray:[condition parameters]];
    [request setPredicate:predicate];
    
    // ソート
    [request setSortDescriptors:[condition convertSortDescriptors]];
    
    // フェッチリミット
    if ([condition limit] != nil)
    {
        [request setFetchLimit:[[condition limit] integerValue]];
    }
    
    // フェッチオフセット
    if ([condition offset] != nil)
    {
        [request setFetchOffset:[[condition offset] integerValue]];
    }
    
    // グルーピング
    [request setPropertiesToGroupBy:[condition groupby]];
    
    // ソート
    [request setSortDescriptors:[condition convertSortDescriptors]];
    
    return request;
}

@end
