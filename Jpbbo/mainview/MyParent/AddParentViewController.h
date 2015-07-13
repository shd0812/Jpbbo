//
//  AddParentViewController.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/7.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPCommonViewController.h"

@interface AddParentViewController : JPCommonViewController

@property (nonatomic, strong) IBOutlet UIImageView *headImageView;
@property (nonatomic, strong) IBOutlet UIImageView *codeImageView;

@property (nonatomic, strong) IBOutlet UITextField *nameTF;
@property (nonatomic, strong) IBOutlet UITextField *numberTF;
@property (nonatomic, strong) IBOutlet UITextField *fristCodeTF;

@property (nonatomic,strong) NSString *type;

@end
