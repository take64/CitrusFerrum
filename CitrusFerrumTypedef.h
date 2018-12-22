//
//  CitrusFerrumTypedef.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/05/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#ifndef CitrusFerrumTypedef_h
#define CitrusFerrumTypedef_h

// 汎用ブロック
typedef void (^CitrusFerrumCompleteBlock)(void);

// zero
#define CFDecimalZero [NSDecimalNumber zero]

// coredata status status
#define CFCoreDataStatusNormal @0
#define CFCoreDataStatusRemove @9

#if DEBUG
#define CFLog(...) NSLog(__VA_ARGS__)
#else
#define CFLog(...)
#endif

#endif /* CitrusFerrumTypedef_h */
