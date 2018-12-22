//
//  CFHttpRequest.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/12/22.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFHttpRequest.h"

#import "CFString.h"



@implementation CFHttpRequest



#pragma mark - static method
//
// static method
//

// GETリクエスト
+ (void) getRequest:(NSString *)urlString complete:(CitrusFerrumDataBlock)complete
{
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    CFLog(@"CFHttpRequest.getRequest :%@", urlString);
    NSURLSession *session = [[NSURLSession alloc] init];
    [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (complete != nil)
        {
            complete(data, error);
        }
    }];
}

// GETリクエスト
+ (void) getRequest:(NSString *)urlString parameters:(NSDictionary *)parameters complete:(CitrusFerrumDataBlock)complete
{
    NSMutableString *url = [NSMutableString stringWithString:urlString];
    
    if ([parameters count] > 0)
    {
        NSMutableArray *paramList = [NSMutableArray array];
        for (NSString *key in [parameters allKeys])
        {
            NSString *val = [parameters objectForKey:key];
            [paramList addObject:CFStringf(@"%@=%@", key, val)];
        }
        [url appendFormat:@"?%@", [paramList componentsJoinedByString:@"&"]];
    }
    
    [CFHttpRequest getRequest:[url copy] complete:complete];
}

@end
