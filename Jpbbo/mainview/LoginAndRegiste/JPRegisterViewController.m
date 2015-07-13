//
//  JPRegisterViewController.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/4.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "JPRegisterViewController.h"
#import "HttpLoginAction.h"
#import "Utils.h"

@interface JPRegisterViewController (){
    BOOL requestFlag;
}

@end

@implementation JPRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.opType isEqualToString:@"forget"]) {
        [self setTitle:@"忘记密码"];
    }else{
        [self setTitle:@"会员注册"];
    }
    
    [self.registerBtn.layer setMasksToBounds:YES];
    [self.registerBtn.layer setCornerRadius:5.0];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_accountTF resignFirstResponder];
    [_codeTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    [_respassTF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(IBAction)getCode:(id)sender{
    
    if ([self.accountTF.text isEqualToString:@""] || [self.accountTF.text isEqualToString:nil]) {
        [Utils showToastWithText:@"手机号不能为空"];
        return;
    }
    
    requestFlag = YES;
    [self showActivityView:self.view];
    
    [HttpLoginAction getVerifiCode:self.accountTF.text opType:self.opType complete:^(id result, NSError *error) {
        int flag=[(NSNumber*)[result valueForKey:@"ResultFlag"]intValue];
        NSString *resultMsg=[result valueForKey:@"ResultMsg"];
        
        if (flag ==1) {
            [Utils showToastWithText:resultMsg];
            
            //[self.navigationController popViewControllerAnimated:YES];
        }else{
            [Utils showToastWithText:resultMsg];
        }
        requestFlag=false;
        [self stopActivityView];
    }];

}

-(IBAction)submitBtn:(id)sender{
    
    if (requestFlag)
        return;

    if ([self.accountTF.text isEqualToString:@""] ||[self.accountTF.text isEqualToString:nil]) {
        [Utils showToastWithText:@"手机号不能为空"];
        return;
    }
    
    if ([self.codeTF.text isEqualToString:@""] ||[self.codeTF.text isEqualToString:nil]) {
        [Utils showToastWithText:@"验证码不能为空"];
   
        return;
    }
    
    if ([self.passwordTF.text isEqualToString:@""] ||[self.passwordTF.text isEqualToString:nil]) {
        [Utils showToastWithText:@"密码不能为空"];

        return;
    }
    
    if (![self.passwordTF.text isEqualToString:self.respassTF.text]) {
        [Utils showToastWithText:@"密码不一致"];
        return;
    }
    
    requestFlag = YES;
    [self showActivityView:self.view];
    
    [HttpLoginAction registerOrForgetPass:self.accountTF.text password:self.passwordTF.text opType:self.opType code:self.codeTF.text complete:^(id result, NSError *error) {
        
        int flag=[(NSNumber*)[result valueForKey:@"ResultFlag"]intValue];
        NSString *resultMsg=[result valueForKey:@"ResultMsg"];
        
        if (flag ==1) {
            [Utils showToastWithText:resultMsg];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [Utils showToastWithText:resultMsg];
        }
        requestFlag=false;
        [self stopActivityView];
    }];
}



@end
