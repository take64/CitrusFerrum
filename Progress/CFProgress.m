//
//  CFProgress.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/05/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFProgress.h"



@implementation CFProgress

#pragma mark - synthesize
//
// synthesize
//
@synthesize current;
@synthesize total;
@synthesize percentage;



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithCurrent:(NSNumber *)currentValue total:(NSNumber *)totalValue
{
    self = [super init];
    if (self)
    {
        [self setCurrent:currentValue];
        [self setTotal:totalValue];
        // パーセント計算
        [self calcPercentage];
    }
    return self;
}

// 進捗させる
- (void) next
{
    [self setCurrent:@([[self current] intValue] + 1)];
    [self calcPercentage];
}

// 完了したか？
- (BOOL) isCompleted
{
    return ([[self current] compare:[self total]] == NSOrderedSame);
}


#pragma mark - private
//
// private
//

// パーセント計算して設定後取得
- (NSNumber *) calcPercentage
{
    double _percentage = ([[self current] doubleValue] / [[self total] doubleValue]);
    if (isnan(_percentage) == TRUE || _percentage < 0)
    {
        _percentage = 0;
    }
    [self setPercentage:@(_percentage)];
    return [self percentage];
}



#pragma mark - static method
//
// static method
//

// 完了状態で初期化
+ (instancetype) complete
{
    return [[self alloc] initWithCurrent:@1 total:@1];
}

// 初期化
+ (instancetype) newWithCurrent:(NSNumber *)currentValue total:(NSNumber *)totalValue
{
    return [[self alloc] initWithCurrent:currentValue total:totalValue];
}

@end
