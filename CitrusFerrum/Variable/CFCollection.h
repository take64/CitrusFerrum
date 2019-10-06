//
//  CFCollection.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFCollection : NSObject

//
// static method
//

// 一覧情報のソート(NSArray) @[ @{'column1', @0}, @{'column', @1} ]
+ (NSArray *) sortWithEntitySet:(NSSet *)setList sort:(NSArray *)sortList;

// 一覧情報のソート(NSArray) @[ @{'column1', @0}, @{'column', @1} ]
+ (NSArray *) sortWithEntityArray:(NSArray *)arrayList sort:(NSArray *)sortList;

// 配列オブジェクト内のオブジェクトを配列で返す
+ (NSArray *) arrayWithEntityArray:(NSArray *)arrayList keyPath:(NSString *)keyPath;

// 配列オブジェクトをキーでソートする
+ (NSArray *) sortOfKeyWithArray:(NSArray *)arrayList;

@end
