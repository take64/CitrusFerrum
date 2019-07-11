//
//  CFCoreDataRequest.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/08/08.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CFCoreDataCondition;

@interface CFCoreDataRequest : NSObject


//
// method
//

// 初期化
- (instancetype) initWithContext:(NSManagedObjectContext *)context entityName:(NSString *)entityName;

// データ取得
- (NSArray *) requestWithCondition:(CFCoreDataCondition *)condition;

// データ取得(1件)
- (NSManagedObject *) objectWithCondition:(CFCoreDataCondition *)condition;

// データ取得(全件)
- (NSArray *) listWithCondition:(CFCoreDataCondition *)condition;

// フェッチ取得
- (NSFetchedResultsController *) fetchWithSectionNameKeyPath:(NSString *)sectionNameKeyPath cacheName:(NSString *)cacheName refreshCache:(BOOL)refrechCache condition:(CFCoreDataCondition *)condition;

// count取得(1件)
- (NSNumber *) countWithColumnName:(NSString *)columnName condition:(CFCoreDataCondition *)condition;

// max取得(1件)
- (NSNumber *) maxWithColumnName:(NSString *)columnName condition:(CFCoreDataCondition *)condition;

// min取得(1件)
- (NSNumber *) minWithColumnName:(NSString *)columnName condition:(CFCoreDataCondition *)condition;

// average取得(1件)
- (NSNumber *) averageWithColumnName:(NSString *)columnName condition:(CFCoreDataCondition *)condition;

// sum取得(1件)
- (NSNumber *) sumWithColumnName:(NSString *)columnName condition:(CFCoreDataCondition *)condition;

@end
