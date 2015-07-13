//
//  HttpParentAction.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/9.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpBaseAction.h"
#import "RMMapper.h"
#import "MyParents.h"

@interface HttpParentAction : NSObject

//添加设备
+(void)addParentWatch:(NSString *)imsi UID:(NSString*)ID account:(NSString *)account number:(NSString *)number name:(NSString *)name complete:(HttpCompleteBlock)block;

+(void)addSeParentWatch:(NSString *)imsi account:(NSString *)account UID:(NSString *)ID number:(NSString *)number name:(NSString *)name PhoneNumber:(NSString *)PhoneNumber Birthday:(NSString*)Birthday Sex:(NSString*)Sex Height:(NSString*)Height Weight:(NSString*)Weight Step:(NSString*)Step Relationship:(NSString*)Relationship complete:(HttpCompleteBlock)block;


+(void)getManagerSetList:(NSString *)UID complete:(HttpCompleteBlock)block;

+(void)getParentsDetail:(NSString*)EID complete:(HttpCompleteBlock)block;

+(void)deleteRelate:(NSString*)EID UID:(NSString*)UID complete:(HttpCompleteBlock)block;

+(void)getRateDetail:(NSString*)EID complete:(HttpCompleteBlock)block;

+(void)getPedometerDetail:(NSString*)EID complete:(HttpCompleteBlock)block;

+(void)addRateSet:(NSString *)UID EID:(NSString*)EID Switch:(NSInteger)Switch HeartRateUpTime:(NSString*)HeartRateUpTime WhetherWarning:(NSInteger)WhetherWarning HeartrateTop:(NSString*)HeartrateTop HeartrateLower:(NSString*)HeartrateLower complete:(HttpCompleteBlock)block;

+(void)addPedometerSet:(NSString *)UID EID:(NSString*)EID Switch:(NSInteger)Switch MovementUpTime:(NSString*)MovementUpTime Target:(NSString*)Target complete:(HttpCompleteBlock)block;

@end
