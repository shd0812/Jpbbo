//
//  MyParents.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/9.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyParents : NSObject

@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *IMEI;
@property (nonatomic,strong) NSString *IdentityNumber;
@property (nonatomic,strong) NSString *PhoneNumber;
@property (nonatomic,assign) int Sex;
@property (nonatomic,strong) NSString *Step;
@property (nonatomic,strong) NSString *Weight;
@property (nonatomic,strong) NSString *Status;
@property (nonatomic,strong) NSString *Height;
@property (nonatomic,strong) NSString *EntityState;
@property (nonatomic,strong) NSString *CustomerName;

@property (nonatomic,strong) NSString *NowAddress;
@property (nonatomic,strong) NSString *PhotoParth;

@property (nonatomic,assign) float Longitude;
@property (nonatomic,assign) float Latitude;
@property (nonatomic,strong) NSString *Birthday;

@property (nonatomic,strong) NSString *NickName;

@end
