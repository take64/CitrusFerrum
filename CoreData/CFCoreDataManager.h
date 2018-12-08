//
//  CFCoreDataManager.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/08/08.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CFCoreDataManager : NSObject

//
// method
//

// 初期化
- (instancetype) initWithStorePath:(NSString *)storePath modelName:(NSString *)modelName modelExtension:(NSString *)modelExtension;

// 保存
- (BOOL) saveContext;

// 保存&マージ
- (void) saveWithMergeObject:(NSManagedObject *)managedObject;

// 保存＆mainThread保存
- (void) saveComplete;

// 削除
- (BOOL) deleteWithSave:(NSManagedObject *)managedObject;

// ロールバック
- (void) rollbackContext;

//// 保存通知
//- (void) managedObjectContextDidSave:(NSNotification *)notification;

// データオブジェクト生成
- (NSManagedObject *)newObjectWithEntityName:(NSString *)entityName;


@end

