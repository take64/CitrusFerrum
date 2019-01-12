//
//  CFSectionDatastore.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2019/01/12.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@interface CFSectionDatastore : NSObject

//
// method
//

// セクション数
- (NSUInteger) sectionCount;

// セクション内オブジェクト数
- (NSUInteger) countAtSection:(NSUInteger)sectionIndex;

// セクションキー
- (NSString *) keyAtSection:(NSUInteger)sectionIndex;

// キーの示すセクションインデックス
- (NSInteger) sectionIndexAtKey:(NSString *)key;

// セクション内オブジェクト(インデックス)
- (NSMutableArray *) objectsAtSection:(NSUInteger)sectionIndex;

// セクション内オブジェクト(キー)
- (NSMutableArray *) objectsAtKey:(NSString *)key;

// IndexPathが示すオブジェクト
- (id) objectAtIndexPath:(NSIndexPath *)indexPath;

// オブジェクトの追加
- (void) addObject:(id)object key:(NSString *)key;

// セクションソート
- (void) sortSectionOfAscending:(BOOL)ascending;

// セクション内オブジェクト
- (void) sortObjectsOfSorts:(NSArray<NSDictionary *> *)sorts;

// 初期化
- (void) empty;



//
// static method
//

// CFCoreDataRequestの結果から生成
+ (CFSectionDatastore *) sectionDatastoreWithEntities:(NSArray<NSManagedObject *> *)entities keyPath:(NSString *)keyPath ascending:(BOOL)ascending;

@end
