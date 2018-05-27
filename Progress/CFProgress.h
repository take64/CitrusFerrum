//
//  CFProgress.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/05/27.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFProgress : NSObject
{
    // 現在
    NSNumber *current;
    // 全行程
    NSNumber *total;
    // 進捗率
    NSNumber *percentage;
}

//
// property
//
@property (nonatomic, retain) NSNumber *current;
@property (nonatomic, retain) NSNumber *total;
@property (nonatomic, retain) NSNumber *percentage;



//
// method
//

// 初期化
- (instancetype)initWithCurrent:(NSNumber *)currentValue total:(NSNumber *)totalValue;

// 進捗させる
- (void)next;

// 完了状態で初期化
+ (instancetype)complete;

// 初期化
+ (instancetype)newWithCurrent:(NSNumber *)currentValue total:(NSNumber *)totalValue;

@end

typedef void (^CitrusFerrumProgressBlock)(CFProgress *progress);
