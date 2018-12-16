//
//  CFEmptyVL.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/16.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFEmptyVL : NSObject

//
// method
//

// NVL関数
+ (id) compare:(id)compare replace:(id)replace;

// NVL2関数
+ (id) compare:(id)compare value1:(id)value1 value2:(id)value2;

@end
