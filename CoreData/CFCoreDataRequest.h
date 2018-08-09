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
- (instancetype) initWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName;

// データ取得
- (NSArray *) requestWithWhereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns fetchLimit:(NSInteger)fetchLimit fetchOffset:(NSInteger)fetchOffset;

// データ取得(1件)
- (NSManagedObject *) objectWithWhereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

// データ取得(1件)
- (NSManagedObject *) objectWithWhereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns;

// データ取得(全件)
- (NSArray *) listWithWhereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns;

// フェッチ取得
- (NSFetchedResultsController *) fetchWithSectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName refreshCache:(BOOL)refrechCache whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters sortColumns:(NSArray *)sortColumns;

// count取得(1件)
- (NSNumber *) countWithColumnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

// count取得(1件)(group by)
- (NSNumber *) countWithColumnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters groupby:(NSArray *)groupby;

// max取得(1件)
- (NSNumber *) maxWithColumnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

// min取得(1件)
- (NSNumber *) minWithColumnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

// average取得(1件)
- (NSNumber *) averageWithColumnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

// sum取得(1件)
- (NSNumber *) sumWithColumnName:(NSString *)columnName whereQuery:(NSString *)whereQuery whereParameters:(NSArray *)whereParameters;

@end
