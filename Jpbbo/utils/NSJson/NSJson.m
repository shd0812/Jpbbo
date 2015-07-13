//
//  NSJson.m
//  Vcam
//
//  Created by zhangrujin on 13-8-10.
//  Copyright (c) 2013年 zhangrujin. All rights reserved.
//

#import "NSJson.h"

#if __has_feature(objc_arc)
#define SAFE_ARC_RELEASE(x)
#define SAFE_ARC_AUTORELEASE(x) (x)
#else
#define SAFE_ARC_RELEASE(x) ([(x) release])
#define SAFE_ARC_AUTORELEASE(x) ([(x) autorelease])
#endif

@implementation NSObject (NSJson)

- (NSString *)JSONRepresentation {
    NSString *json = nil;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return SAFE_ARC_AUTORELEASE(json);
}


- (NSData *)JSONRepresentationData {
    NSData *jsonData = nil;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    }
    return jsonData;
}
@end

@implementation NSString (NSJson)

- (id)jsonValue {
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    if (json == nil) {

    }
    return json;
}

@end

@implementation NSData (NSJson)

- (id)jsonValue {
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&error];
    if (json == nil) {

    }
    return json;
}

@end
