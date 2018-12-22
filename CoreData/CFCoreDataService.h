//
//  CFCoreDataService.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/20.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObject;

@class CFElement;

@interface CFCoreDataService : NSObject

//
// static method
//

// レコードのデータをDictionaryで取得
+ (NSDictionary *) dictionaryWithEntity:(NSManagedObject *)entityValue;

// ObjectデータをEntityにbindする
+ (NSManagedObject *) bindEntity:(NSManagedObject *)entityValue fromObject:(CFElement *)elementValue;

// リクエスト
+ (CFCoreDataRequest *) callRequest;

@end
