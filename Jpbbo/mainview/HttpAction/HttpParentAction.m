//
//  HttpParentAction.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/9.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "HttpParentAction.h"
#import "ServiceCode.h"

@implementation HttpParentAction

+(void)addParentWatch:(NSString *)imsi UID:(NSString*)ID account:(NSString *)account number:(NSString *)number name:(NSString *)name complete:(HttpCompleteBlock)block{
    
    NSString *mothed=[NSString stringWithFormat:@"method=%@&IdentityNumber=%@&IMEI=%@&CustomerName=%@&UID=%@",@"VerificationEquipment",number,imsi,name,ID];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
       
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];

}

+(void)addSeParentWatch:(NSString *)imsi account:(NSString *)account UID:(NSString *)ID number:(NSString *)number name:(NSString *)name PhoneNumber:(NSString *)PhoneNumber Birthday:(NSString*)Birthday Sex:(NSString*)Sex Height:(NSString*)Height Weight:(NSString*)Weight Step:(NSString*)Step Relationship:(NSString*)Relationship complete:(HttpCompleteBlock)block{

    NSString *mothed=[NSString stringWithFormat:@"method=%@&CustomerName=%@&IdentityNumber=%@&IMEI=%@&UID=%@&PhoneNumber=%@&Birthday=%@&Sex=%@&Height=%@&Weight=%@&Step=%@&Relationship=%@",@"AddEquipment",name,number,imsi,ID,PhoneNumber,Birthday,Sex,Height,Weight,Step,Relationship];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+(void)getManagerSetList:(NSString *)UID complete:(HttpCompleteBlock)block{

    NSString *mothed=[NSString stringWithFormat:@"method=%@&UID=%@",@"GetEquipmentListByUserID",UID];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        NSInteger flag=[(NSNumber*)[result objectForKey:@"ResultFlag"]integerValue];
        if (flag ==0) {
            block(nil,error);
        }else{
            NSArray *returnArray=(NSArray*)[result objectForKey:@"ResultData"];
            if(returnArray.count>0) {
                block(returnArray,nil);
            }else {
                block(nil,error);
            }
        }
    }];
}

+(void)getParentsDetail:(NSString*)EID complete:(HttpCompleteBlock)block{
    
    NSString *mothed=[NSString stringWithFormat:@"method=%@&EID=%@",@"GetEquipmentDataByEID",EID];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+(void)deleteRelate:(NSString*)EID UID:(NSString*)UID complete:(HttpCompleteBlock)block{
    
    NSString *mothed=[NSString stringWithFormat:@"method=%@&EID=%@&UID=%@",@"CancelRelation",EID,UID];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+(void)getRateDetail:(NSString*)EID complete:(HttpCompleteBlock)block{

    NSString *mothed=[NSString stringWithFormat:@"method=%@&EID=%@",@"GetHeartRateWarningConfigByEID",EID];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+(void)getPedometerDetail:(NSString*)EID complete:(HttpCompleteBlock)block{

    NSString *mothed=[NSString stringWithFormat:@"method=%@&EID=%@",@"GetMovementWarningConfigByEID",EID];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+(void)addRateSet:(NSString *)UID EID:(NSString*)EID Switch:(NSInteger)Switch HeartRateUpTime:(NSString*)HeartRateUpTime WhetherWarning:(NSInteger)WhetherWarning HeartrateTop:(NSString*)HeartrateTop HeartrateLower:(NSString*)HeartrateLower complete:(HttpCompleteBlock)block{
    
    NSString *mothed=[NSString stringWithFormat:@"method=%@&UID=%@&EID=%@&Switch=%ld&HeartRateUpTime=%@&WhetherWarning=%ld&HeartrateTop=%@&HeartrateLower=%@",@"HeartRateWarningSet",UID,EID,Switch,HeartRateUpTime,WhetherWarning,HeartrateTop,HeartrateLower];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

+(void)addPedometerSet:(NSString *)UID EID:(NSString*)EID Switch:(NSInteger)Switch MovementUpTime:(NSString*)MovementUpTime Target:(NSString*)Target complete:(HttpCompleteBlock)block{

    NSString *mothed=[NSString stringWithFormat:@"method=%@&UID=%@&EID=%@&Switch=%ld&MovementUpTime=%@&Target=%@",@"MovementWarningSet",UID,EID,Switch,MovementUpTime,Target];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,mothed];
    
    [HttpBaseAction getRequest:url complete:^(id result, NSError *error) {
        
        if (error == nil && result) {
            block(result,nil);
        }else{
            block(nil,error);
        }
    }];
}

@end
