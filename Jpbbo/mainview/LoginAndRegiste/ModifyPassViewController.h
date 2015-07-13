//
//  ModifyPassViewController.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/9.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPCommonViewController.h"

@interface ModifyPassViewController : JPCommonViewController

@property (nonatomic, strong) IBOutlet UITextField *oldpass;
@property (nonatomic, strong) IBOutlet UITextField *newpass;
@property (nonatomic, strong) IBOutlet UITextField *repass;

@property (nonatomic, strong) IBOutlet UIButton *submitBtn;

@end
