//
//  CFCoreDataCondition.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/08/09.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFCoreDataCondition : NSObject
{
    NSString *query;
    NSArray *parameters;
    NSArray<NSDictionary *> *sorts;
    NSNumber *limit;
    NSNumber *offset;
    NSArray *groupby;
}

//
// property
//
@property (nonatomic, retain) NSString *query;
@property (nonatomic, retain) NSArray *parameters;
@property (nonatomic, retain) NSArray<NSDictionary *> *sorts;
@property (nonatomic, retain) NSNumber *limit;
@property (nonatomic, retain) NSNumber *offset;
@property (nonatomic, retain) NSArray *groupby;



//
// method
//

// 初期化
- (instancetype) initWithQuery:(NSString *)query parameters:(NSArray *)parameters;

// 初期化
- (instancetype) initWithQuery:(NSString *)query parameters:(NSArray *)parameters sorts:(NSArray *)sorts;

// 初期化
- (instancetype) initWithQuery:(NSString *)query parameters:(NSArray *)parameters sorts:(NSArray *)sorts limit:(NSNumber *)limit offset:(NSNumber *)offset;

// 初期化
- (instancetype) initWithQuery:(NSString *)query parameters:(NSArray *)parameters groupby:(NSArray *)groupby;

// NSSortDescriptor への変換
- (NSMutableArray<NSSortDescriptor *> *) convertSortDescriptors;

@end
