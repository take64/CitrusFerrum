//
//  CFTask.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/05/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFTask.h"

@interface CFTask()

@property NSMutableArray<CFTaskNode *> *nodes;
@property NSNumber *delay;
@property CitrusFerrumProgressBlock progressBlock;

@end



@implementation CFTask

#pragma mark - method
//
// method
//

// 初期化
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setNodes:[NSMutableArray new]];
        [self setDelay:@0];
    }
    return self;
}

// 初期化
- (instancetype)initWithProgress:(CitrusFerrumProgressBlock)block
{
    self = [self init];
    if (self)
    {
        [self setProgressBlock:block];
    }
    return self;
}

// 開始
- (void)start
{
    // 実行予定タスク
    CFTaskNode *nextTask = nil;
    // 実行中タスク
    CFTaskNode *processingTask = nil;
    // タスク数
    int waitCount = 0;
    int processingCount = 0;
    int completeCount = 0;
    int totalCount = 0;
    
    // タスク処理
    for (CFTaskNode *node in [self nodes])
    {
        // 総数
        totalCount++;
        // 処理分け
        switch ([node state])
        {
            case CitrusFerrumTaskStateWait:
                // 実行待ち
                if (nextTask == nil)
                {
                    nextTask = node;
                }
                waitCount++;
                break;
                
            case CitrusFerrumTaskStateProcessing:
                // 実行中
                processingTask = node;
                processingCount++;
                break;
                
            case CitrusFerrumTaskStateComplete:
                // 実行終了
                completeCount++;
                break;
                
            default:
                break;
        }
    }
    
    // 実行中タスクがない場合は、実行予定タスクを実行
    if (processingTask == nil && nextTask != nil)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, [[self delay] doubleValue] * NSEC_PER_SEC), [CFTask sharedQueue], ^{
            [nextTask start];
        });
        
        dispatch_async([CFTask sharedQueue], ^{
            [nextTask setState:CitrusFerrumTaskStateComplete];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.progressBlock != nil)
                {
                    self.progressBlock([CFProgress newWithCurrent:@(completeCount+1) total:@(totalCount)]);
                }
                
                // 回帰実行する
                if ([nextTask chainAutoStart] == YES)
                {
                    [self start];
                }
            });
        });
    }
}

// タスクの追加
- (void)addTask:(CitrusFerrumTaskBlock)block
{
    [self addTask:block chainAutoStart:YES];
    
}

// タスクの追加
- (void)addTask:(CitrusFerrumTaskBlock)block chainAutoStart:(BOOL)autoStart
{
    [[self nodes] addObject:[CFTaskNode taskWithBlock:block chainAutoStart:autoStart]];
}


#pragma mark - caller
//
// caller
//

// shared queue
+ (dispatch_queue_t)sharedQueue
{
    static dispatch_queue_t queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("tk.citrus.ferrum.task", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}

@end
