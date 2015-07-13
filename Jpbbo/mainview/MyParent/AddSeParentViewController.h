//
//  AddSeParentViewController.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/9.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPCommonViewController.h"
#import "MyParents.h"

@interface AddSeParentViewController : JPCommonViewController

@property (nonatomic,strong) MyParents *myparents;

@property (nonatomic,strong) IBOutlet UITextField *sexTF;
@property (nonatomic,strong) IBOutlet UITextField *brithTF;
@property (nonatomic,strong) IBOutlet UITextField *heigthTF;
@property (nonatomic,strong) IBOutlet UITextField *weigtTF;
@property (nonatomic,strong) IBOutlet UITextField *stepTF;

@property (nonatomic,strong) IBOutlet UITextField *nickTF;
@property (nonatomic,strong) IBOutlet UITextField *phoneTF;


@end
