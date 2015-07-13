//
//  JPCommonViewController.h
//  JPbbo
//
//  Created by jpbbo on 15/7/3.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetRequestOperation.h"
#import "UIImageView+WebCache.h"
#import "ModulesManager.h"
#import "Utils.h"
#import "BlockObject.h"

@interface JPCommonViewController : UIViewController

@property (nonatomic,strong) MBProgressHUD *hud;
- (void)showTotalMsg:(NSString *)msg andView:(UIView *)view;

//进度轮的控制
@property(nonatomic, strong)UIActivityIndicatorView *activityView;

@property(nonatomic, strong) NetRequestOperation *netWorkOperation;

-(void)showActivityView:(UIView*)view;
-(void)stopActivityView;

@end
