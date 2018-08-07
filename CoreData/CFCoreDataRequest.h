//
//  CFCoreDataRequest.h
//  ChinottoPod
//
//  Created by kouhei.takemoto on 2018/08/08.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CFCoreDataRequest : NSObject


//
// method
//

// 初期化
- (instancetype) initWithContext:(NSManagedObjectContext *)context;

// データ取得
- (NSArray *) requestWithEntityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns fetchLimit:(NSInteger)fetchLimit fetchOffset:(NSInteger)fetchOffset;

// データ取得(1件)
- (NSManagedObject *) objectWithEntityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

// データ取得(1件)
- (NSManagedObject *) objectWithEntityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns;

// データ取得(全件)
- (NSArray *) listWithEntityName:(NSString *)entityName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns;

// フェッチ取得
- (NSFetchedResultsController *) fetchWithEntityName:(NSString *)entityName sectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName refreshCache:(BOOL)refrechCache whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns;

// count取得(1件)
- (NSNumber *) countWithEntityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

// count取得(1件)(group by)
- (NSNumber *) countWithEntityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters groupby:(NSArray *)groupby;

// max取得(1件)
- (NSNumber *) maxWithEntityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

// min取得(1件)
- (NSNumber *) minWithEntityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

// average取得(1件)
- (NSNumber *) averageWithEntityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

// sum取得(1件)
- (NSNumber *) sumWithEntityName:(NSString *)entityName columnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

@end
