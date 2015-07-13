//
//  ModulesManager.h
//  JPbbo
//
//  Created by jpbbo on 15/7/3.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "UserDefault.h"

@interface ModulesManager : NSObject

@property (nonatomic,strong) UINavigationController *navigationController;
@property (nonatomic,strong) UITabBarController *tabBarController;

+ (ModulesManager *)defaultManager;

-(BOOL)login;

/**
 *判断用户当前网络状态
 */
-(BOOL)isExistNetWork;
-(BOOL)checkNetworkConnection;

@end
