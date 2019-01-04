//
//  CFTask.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/05/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CFTaskNode.h"
#import "CFProgress.h"

@interface CFTask : NSObject

//
// property
//

@property (nonatomic, copy) CitrusFerrumProgressBlock progressBlock;



//
// method
//

// 初期化
- (instancetype) initWithProgress:(CitrusFerrumProgressBlock)block;

// 開始
- (void) start;

// タスクの追加
- (void) addTask:(CitrusFerrumTaskBlock)block;

// タスクの追加
- (void) addTask:(CitrusFerrumTaskBlock)block chainAutoStart:(BOOL)autoStart;

@end
