//
//  CFBusiness.h
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/22.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CFBusiness : NSObject

//
// static method
//

// entity用ユニークID
+ (NSString *) uniqueID;

// entity用ユニークID
+ (NSString *) uniqueIDSeed1:(NSString *)seed1 seed2:(NSString *)seed2;

// entity配列のdictionary配列化
+ (NSArray *) dictionariesWithEntities:(NSArray *)entities;

// dictionary配列からentityに変換
+ (NSManagedObject *) entityWithEntity:(NSManagedObject *)entityValue withDictionary:(NSDictionary *)dicValue;

@end
