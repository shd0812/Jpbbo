//
//  JPLoginViewController.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/4.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPCommonViewController.h"

@interface JPLoginViewController : JPCommonViewController

@property (nonatomic,strong) IBOutlet UITextField *account;
@property (nonatomic,strong) IBOutlet UITextField *password;


@property (nonatomic,strong) IBOutlet UIButton *loginBtn;
@property (nonatomic,strong) IBOutlet UIButton *forgetBtn;
@property (nonatomic,strong) IBOutlet UIButton *registerBtn;



@end
