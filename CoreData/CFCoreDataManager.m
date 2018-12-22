//
//  CFCoreDataManager.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/08/08.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFCoreDataManager.h"

static NSString * const kCoreDataManagerContextThreadKey = @"CFCoreDataManagerContextThreadKey";

@interface CFCoreDataManager()

#pragma mark - property
//
// property
//
@property NSManagedObjectContext *objectContext;            // コンテクスト
@property NSManagedObjectModel *objectModel;                // モデル
@property NSPersistentStoreCoordinator *storeCoordinator;   // ストア
@property NSString *modelName;                              // モデル名
@property NSString *modelExtension;                         // モデル名拡張子
@property NSString *storePath;                              // ストアパス

@end



@implementation CFCoreDataManager

#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithStorePath:(NSString *)storePath modelName:(NSString *)modelName modelExtension:(NSString *)modelExtension
{
    self = [super init];
    if (self)
    {
        // 初期設定
        [self setModelName      :modelName];
        [self setModelExtension :modelExtension];
        [self setStorePath      :storePath];
    }
    return self;
}

// 保存
- (BOOL) saveContext
{
    NSManagedObjectContext *context = [self managedObjectContextForCurrentThread];
    BOOL isMainThread = [[NSThread currentThread] isMainThread];
    
    // 返却値
    BOOL result;
    
    // メインスレッドでない場合は通知する
    if (isMainThread == NO)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(managedObjectContextDidSave:)
                                                     name:NSManagedObjectContextDidSaveNotification
                                                   object:context];
        
        // 保存処理
        NSError *error;
        result = [context save:&error];
        if (error != nil)
        {
            NSLog(@"error : %@", error);
        }
        
        // 通知削除
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:NSManagedObjectContextDidSaveNotification
                                                      object:context];
    }
    else
    {
        // 保存処理
        result = [context save:nil];
    }
    
    return result;
}

// 保存&マージ
- (void) saveWithMergeObject:(NSManagedObject *)managedObject
{
    // 保存
    [self saveContext];
    
    // マージ
    [[self managedObjectContextForCurrentThread] refreshObject:managedObject mergeChanges:YES];
}

// 削除
- (BOOL) deleteWithSave:(NSManagedObject *)managedObject
{
    // 削除
    [[self managedObjectContextForCurrentThread] deleteObject:managedObject];
    
    // 保存
    return [self saveContext];
}

// 保存＆mainThread保存
- (void) saveComplete
{
    [self saveContext];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self saveContext];
    });
}

// ロールバック
- (void) rollbackContext
{
    NSManagedObjectContext *context = [self managedObjectContextForCurrentThread];
    [context rollback];
}

// データオブジェクト生成
- (NSManagedObject *) newObjectWithEntityName:(NSString *)entityName
{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self managedObjectContextForCurrentThread]];
}

// コンテクスト(カレントスレッド)
- (NSManagedObjectContext *) managedObjectContextForCurrentThread
{
    return [self managedObjectContext:[NSThread currentThread]];
}



#pragma mark - private
//
// private
//

// コンテクスト
- (NSManagedObjectContext *) managedObjectContext:(NSThread *)thread
{
    // 対象スレッドからコンテキスト取得
    NSMutableDictionary *threadDictionary = [thread threadDictionary];
    NSManagedObjectContext *context = [threadDictionary objectForKey:kCoreDataManagerContextThreadKey];
    
    // 取得できない場合
    if (context == nil)
    {
        // 生成
        context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        // ストア関連付け
        [context setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
        // 現在スレッドに設定
        [[thread threadDictionary] setObject:context forKey:kCoreDataManagerContextThreadKey];
        // マージポリシー
        [context setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
    }
    
    return context;
}

// コンテクスト(メインスレッド)
- (NSManagedObjectContext *) managedObjectContextForMainThread
{
    return [self managedObjectContext:[NSThread mainThread]];
}

// モデル
- (NSManagedObjectModel *) managedObjectModel
{
    if ([self objectModel] != nil)
    {
        return [self objectModel];
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:[self modelName] withExtension:[self modelExtension]];
    [self setObjectModel:[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL]];
    
    return [self objectModel];
}

// ストア
- (NSPersistentStoreCoordinator *) persistentStoreCoordinator
{
    if ([self storeCoordinator] != nil)
    {
        return [self storeCoordinator];
    }
    
    NSURL *storeURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:[self storePath]];
    
    
    NSDictionary *options = @{NSSQLitePragmasOption:@{@"journal_mode":@"DELETE"},
                              NSMigratePersistentStoresAutomaticallyOption:@YES,
                              NSInferMappingModelAutomaticallyOption:@YES,
                              };
    
    NSError *error = nil;
    [self setStoreCoordinator:
     [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]]
     ];
    if (![[self storeCoordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
    {
        NSLog(@"Unresolved error %@", error);
        NSLog(@"%@", [error userInfo]);
        abort();
    }
    
    return [self storeCoordinator];
}

// 保存通知
- (void) managedObjectContextDidSave:(NSNotification *)notification
{
    NSManagedObjectContext *context = [self managedObjectContextForMainThread];
    
    [context performSelectorOnMainThread:@selector(mergeChangesFromContextDidSaveNotification:)
                              withObject:notification
                           waitUntilDone:YES];
}

@end
