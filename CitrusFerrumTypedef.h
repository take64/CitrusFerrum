//
//  CitrusFerrumTypedef.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/05/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#ifndef CitrusFerrumTypedef_h
#define CitrusFerrumTypedef_h

typedef void (^CitrusFerrumCompleteBlock)(void);

#if DEBUG
#define CFLog(...) NSLog(__VA_ARGS__)
#else
#define CFLog(...)
#endif

#endif /* CitrusFerrumTypedef_h */
