//
//  HttpBaseAction.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/2.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UserDefault.h"

typedef void (^HttpCompleteBlock)(id result,NSError *error);

@interface HttpBaseAction : NSObject

+ (void)postRequest:(NSMutableDictionary *)parameters url:(NSString *)url complete:(HttpCompleteBlock)block;


+(void)getRequest:(NSString*)str complete:(HttpCompleteBlock)block;

@end
