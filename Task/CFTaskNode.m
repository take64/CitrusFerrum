//
//  CFTaskNode.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/05/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFTaskNode.h"

@interface CFTaskNode()

@property CitrusFerrumTaskBlock block;

@end



@implementation CFTaskNode

#pragma mark - synthesize
//
// synthesize
//
@synthesize state;
@synthesize chainAutoStart;



#pragma mark - method
//
// method
//

// 初期化
- (instancetype)initWithBlock:(CitrusFerrumTaskBlock)block
{
    return [self initWithBlock:block chainAutoStart:YES];
}

// 初期化
- (instancetype)initWithBlock:(CitrusFerrumTaskBlock)block chainAutoStart:(BOOL)autoStart
{
    self = [super init];
    if (self)
    {
        // 状態
        [self setState:CitrusFerrumTaskStateWait];
        // タスク
        [self setBlock:block];
        // 次のタスクを自動スタート
        [self setChainAutoStart:autoStart];
    }
    return self;
}

// 初期化
+ (instancetype)taskWithBlock:(CitrusFerrumTaskBlock)block
{
    return [[self alloc] initWithBlock:block];
}

// 初期化
+ (instancetype)taskWithBlock:(CitrusFerrumTaskBlock)block chainAutoStart:(BOOL)autoStart
{
    return [[self alloc] initWithBlock:block chainAutoStart:autoStart];
}

// タスク実行
- (void)start
{
    // タスクを実行中に変更
    [self setState:CitrusFerrumTaskStateProcessing];
    
    // タスク開始
    if (self.block != nil)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.block();
        });
    }
}

@end
