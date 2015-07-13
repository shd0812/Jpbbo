//
//  HttpLoginAction.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/4.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpBaseAction.h"

@interface HttpLoginAction : NSObject

+ (void)loginWithAccount:(NSString *)account password:(NSString *)password complete:(HttpCompleteBlock)block;

+ (void)registerOrForgetPass:(NSString *)account password:(NSString *)password opType:(NSString*)opType code:(NSString*)code complete:(HttpCompleteBlock)block;

+ (void)modifyPass:(NSString *)account oldPass:(NSString *)oldpass newPass:(NSString *)newpass UID:(NSString*)ID complete:(HttpCompleteBlock)block;

+ (void)getVerifiCode:(NSString*)account opType:(NSString*)opType complete:(HttpCompleteBlock)block;

+ (void)logoutComplete:(HttpCompleteBlock)block;

+ (void)modifyInfo:(NSString*)UID account:(NSString*)account Nickname:(NSString*)Nickname TrueName:(NSString*)TrueName SexID:(NSString*)SexID Birthday:(NSString*)Birthday Mail:(NSString*)Mail Tel:(NSString*)Tel complete:(HttpCompleteBlock)block;

@end
