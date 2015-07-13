//
//  NSJson.h
//  Vcam
//
//  Created by zhangrujin on 13-8-10.
//  Copyright (c) 2013年 zhangrujin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (NSJson)

- (NSString *)JSONRepresentation;

- (NSData *)JSONRepresentationData;

@end


@interface NSString (NSJson)

- (id)jsonValue;

@end

@interface NSData (NSJson)

- (id)jsonValue;

@end
