//
//  CFObject.m
//  CitrusFerrum
//
//  Created by kouhei.takemoto on 2018/05/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFObject.h"

#import "objc/runtime.h"

@implementation CFObject

#pragma mark - c like method
//
// c like method
//

// 型取得
static const char * callPropertyType(objc_property_t property)
{
    const char *attributes = property_getAttributes(property);
    char *attribute;
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer;
    while ((attribute = strsep(&state, ",")) != NULL)
    {
        if (attribute[0] != 'T')
        {
            continue;
        }
        
        // C primitive type
        if (attribute[1] != '@')
        {
            return (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
        }
        // Objective-C id type
        else if (attribute[1] == '@' && strlen(attribute) == 2)
        {
            return "id";
        }
        // Objective-C object type
        else if (attribute[1] == '@')
        {
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "";
}



#pragma mark - method
//
// method
//

// description
- (NSString *)description
{
    NSMutableString *result = [NSMutableString string];
    
    // クラス名とポインタ
    NSString *className = NSStringFromClass([self class]);
    NSString *address = [NSString stringWithFormat:@"%p", self];
    [result appendFormat:@"<%@: %@> {\n", className, address];
    
    // プロパティー
    unsigned int count;
    unsigned int i;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        const char *property_name = property_getName(property);
        if (property_name != NULL)
        {
            const char *property_type = callPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:property_name];
            [result appendFormat:@"\t(%@) %@ = %@\n",
             [NSString stringWithUTF8String:property_type],
             propertyName,
             [self valueForKey:propertyName]
             ];
        }
    }
    [result appendString:@"}"];
    free(properties);
    
    return [result copy];
}

@end
