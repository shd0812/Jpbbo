//
//  Utils.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/2.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"


@interface Utils : NSObject

//加载数据特效
+ (MBProgressHUD *)showProgressHUDWithText:(NSString *)text;

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, assign) NSInteger hudReference;

+ (void) showLoadingView;
+ (void) hideLoadingView;

//提示文字
+ (void)showToastWithText:(NSString *)text;
+ (void)showToastWithText:(NSString *)text isLoading:(BOOL)isLoading isBottom:(BOOL)isBottom;

//AlertView
+ (void)showAlertView:(NSString *)title :(NSString *)message :(NSString*)enterStr;

+ (void)showAlertView:(NSString *)title :(NSString *)message :(NSString *)sureStr :(NSString *)cancelStr;

//TabBar控制
+ (void)hideTabBar:(UIViewController *)vc;
+ (void)showTabBar:(UIViewController *)vc;

//背景虚化弹出框
@property (nonatomic, strong) UIView *popup;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIImageView *blurView;
@property (nonatomic, strong) UIView *contentHolder;
@property (nonatomic, assign) CGAffineTransform initialPopupTransform;
+ (void)showPopup:(UIView*)pop;
+ (void)dismissPopup;

//本地通知
+ (void)addLocalNotification:(NSString *)title :(NSString *)content;
+ (void)removeAllLocalNotification;

//Print 对象的属性值：最下层类结构
+ (void)printObject:(id)obj;

//系统工具
+ (BOOL)isSimCardInstalled;//判断手机是否装有sim卡
+ (void)makePhoneCall:(NSString *)tel;

//g根据积分设置设置星标，星标替换自己的
//+(UIView *)setLevelImageWithIntegral:(int)intgral;

//获取版本信息
+ (NSString *)getVersion;



@end
