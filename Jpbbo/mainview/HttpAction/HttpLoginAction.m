//
//  HttpLoginAction.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/4.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "HttpLoginAction.h"
#import "NSJson.h"
#import "ServiceCode.h"

@implementation HttpLoginAction

+ (void)loginWithAccount:(NSString *)account password:(NSString *)password complete:(HttpCompleteBlock)block {

    long long value = (arc4random() % 1000000000000000)+100000000000000;
    NSString *imsi = [NSString stringWithFormat:@"%lld", value];
    
    NSString *mothed=[NSString stringWithFormat:@"method=%@&UserName=%@&Password=%@",@"OrdinaryUserLogin",account,password];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        if (error == nil && result) {
            
            int flag=[(NSNumber*)[result valueForKey:@"ResultFlag"]intValue];
            NSDictionary *objectData = [result valueForKey:@"ResultData"];
            
            if (flag ==1) {
                NSString *account=[objectData objectForKey:@"UserName"];
                if ((NSNull *)account != [NSNull null]) {
                    UserDefaultEntity.uid=[objectData valueForKey:@"ID"];
                    UserDefaultEntity.account=[objectData valueForKey:@"UserName"];
                    UserDefaultEntity.session_id=imsi;
                    UserDefaultEntity.nickName=[objectData valueForKey:@"NickName"];
                    UserDefaultEntity.realName=[objectData valueForKey:@"TrueName"];
                    
                    [UserDefault saveUserDefault];
                }
            }
            
            block(result,nil); 
        }else{
            block(nil,error);
        }
    }];
}

+ (void)modifyPass:(NSString *)account oldPass:(NSString *)oldpass newPass:(NSString *)newpass UID:(NSString*)ID complete:(HttpCompleteBlock)block{
    
    NSString *mothed=[NSString stringWithFormat:@"method=%@&UserName=%@&UID=%@&OriginalPass=%@&NewPass=%@",@"UpdatePassWord",account,ID,oldpass,newpass];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];

}

+(void)registerOrForgetPass:(NSString *)account password:(NSString *)password opType:(NSString*)opType code:(NSString*)code complete:(HttpCompleteBlock)block{
    
    NSString *url;
    if ([opType isEqualToString:@"register"]) {
        
        NSString *mothed=[NSString stringWithFormat:@"method=%@&UserName=%@&Password=%@&Verification=%@",@"CreateUser",account,password,code];
        
        url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,mothed];
    } else {
        
        NSString *mothed=[NSString stringWithFormat:@"method=%@&UserName=%@&Password=%@&Verification=%@",@"ResetPassWord",account,password,code];
        
        url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,mothed];
    }
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

//Type：验证类型（1、注册2、动态登录3、重置密码）
+(void)getVerifiCode:(NSString *)account opType:(NSString*)opType complete:(HttpCompleteBlock)block{
    
    NSString *mothed;
    if ([opType isEqualToString:@"register"]) {
        mothed=[NSString stringWithFormat:@"method=%@&PhoneNumber=%@&Type=%@",@"CreateVerificationCode",account,@"1"];
    }else{
        mothed=[NSString stringWithFormat:@"method=%@&PhoneNumber=%@&Type=%@",@"CreateVerificationCode",account,@"3"];
    }
    
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        if (error == nil && result) {
            block(result,nil);
        } else {
            block(nil,error);
        }
    }];
}

+ (void)modifyInfo:(NSString*)UID account:(NSString*)account Nickname:(NSString*)Nickname TrueName:(NSString*)TrueName SexID:(NSString*)SexID Birthday:(NSString*)Birthday Mail:(NSString*)Mail Tel:(NSString*)Tel  complete:(HttpCompleteBlock)block{

    NSString *mothed=[NSString stringWithFormat:@"method=%@&UserName=%@&UID=%@&Nickname=%@&TrueName=%@&SexID=%@&Birthday=%@&Mail=%@&Tel=%@",@"UpdateUserInfo",account,UID,Nickname,TrueName,SexID,Birthday,Mail,Tel];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        if (error == nil && result) {
            
            NSDictionary *memberUesr = [result valueForKey:@"ResultData"];
            NSString *account=[NSString stringWithFormat:@"%@",[memberUesr objectForKey:@"UserName"]];
            if ([account length] > 0) {
                
                UserDefaultEntity.uid = [memberUesr valueForKey:@"ID"];
                UserDefaultEntity.uuid=[memberUesr valueForKey:@"uuid"];
                UserDefaultEntity.zoneCode = CityZoneCode;
                if ([UserDefaultEntity.zoneCode length] == 0) {
                    UserDefaultEntity.zoneCode = @"4101";
                }
                UserDefaultEntity.account = [memberUesr valueForKey:@"UserName"];
                UserDefaultEntity.realName = [memberUesr valueForKey:@"TrueName"];
                UserDefaultEntity.nickName = [memberUesr valueForKey:@"Nickname"];
                UserDefaultEntity.telePhone = Tel;
                UserDefaultEntity.birDate = [memberUesr valueForKey:@"Birthday"];
                UserDefaultEntity.userKey=[memberUesr valueForKey:@"userKey"];
                
                UserDefaultEntity.mailAdd = Mail;
                UserDefaultEntity.sex = [memberUesr valueForKey:@"SexID"];
                UserDefaultEntity.refAccount=[memberUesr valueForKey:@"refAccount"];
                UserDefaultEntity.refOneName = [memberUesr valueForKey:@"refOneName"];
                UserDefaultEntity.refTwoName = [memberUesr valueForKey:@"refTwoName"];
                UserDefaultEntity.zone = [memberUesr valueForKey:@"zone"];
                UserDefaultEntity.zoneDetail = [memberUesr valueForKey:@"zoneDetail"];
                UserDefaultEntity.qrPath = [memberUesr valueForKey:@"qrPath"];
                UserDefaultEntity.qrRelPath = [memberUesr valueForKey:@"qrRelPath"];
                
                UserDefaultEntity.headPath = [memberUesr valueForKey:@"HeadImage"];
                
                [UserDefault saveUserDefault];
            }
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
    
}

+ (void)logoutComplete:(HttpCompleteBlock)block {
    UserDefaultEntity.session_id = nil;
    UserDefaultEntity.uid = nil;
    UserDefaultEntity.zoneCode = nil;
    UserDefaultEntity.account = nil;
    UserDefaultEntity.realName = nil;
    UserDefaultEntity.telePhone = nil;
    [UserDefault saveUserDefault];
    block(nil,nil);
}

@end
