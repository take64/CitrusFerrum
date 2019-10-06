//
//  CFNVL.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^CitrusFerrumNVLCollback)(void);

@interface CFNVL : NSObject

// NVL関数
+ (id) compare:(id)compare replace:(id)replace;

// NVL2関数
+ (id) compare:(id)compare value1:(id)value1 value2:(id)value2;

// NVL^CALLBACk関数
+ (id) compare:(id)compare callback:(CitrusFerrumNVLCollback)callback;

@end
