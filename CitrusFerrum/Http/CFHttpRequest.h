//
//  CFHttpRequest.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/22.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CitrusFerrumTypedef.h"

@interface CFHttpRequest : NSObject

//
// static method
//

// GETリクエスト
+ (void) getRequest:(NSString *)urlString complete:(CitrusFerrumDataBlock)complete;

// GETリクエスト
+ (void) getRequest:(NSString *)urlString parameters:(NSDictionary *)parameters complete:(CitrusFerrumDataBlock)complete;

@end
