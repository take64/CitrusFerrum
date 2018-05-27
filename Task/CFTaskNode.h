//
//  CFTaskNode.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/05/27.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CitrusFerrumTaskState) {
    CitrusFerrumTaskStateWait,
    CitrusFerrumTaskStateProcessing,
    CitrusFerrumTaskStateComplete,
};

typedef void (^CitrusFerrumTaskBlock)(void);

@interface CFTaskNode : NSObject
{
    // 実行状態
    CitrusFerrumTaskState state;
    
    // 次のタスクを自動実行するか
    BOOL chainAutoStart;
}

//
// property
//
@property (nonatomic, assign) CitrusFerrumTaskState state;
@property (nonatomic, assign) BOOL chainAutoStart;



//
// method
//

// 初期化
- (instancetype)initWithBlock:(CitrusFerrumTaskBlock)block;

// 初期化
- (instancetype)initWithBlock:(CitrusFerrumTaskBlock)block chainAutoStart:(BOOL)autoStart;

// 初期化
+ (instancetype)taskWithBlock:(CitrusFerrumTaskBlock)block;

// 初期化
+ (instancetype)taskWithBlock:(CitrusFerrumTaskBlock)block chainAutoStart:(BOOL)autoStart;

// タスク実行
- (void)start;

@end
