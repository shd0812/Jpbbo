//
//  JPLoginViewController.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/4.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "JPLoginViewController.h"
#import "HttpLoginAction.h"
#import "JPRegisterViewController.h"
#import "ModulesManager.h"
#import "Utils.h"

@interface JPLoginViewController (){
    BOOL requestFlag;
}

@end

@implementation JPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"登陆"];
    
    [self.loginBtn.layer setMasksToBounds:YES];
    [self.loginBtn.layer setCornerRadius:5.0];
    
    _account.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"Account_name"];
    _password.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"Account_pwd"];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_password resignFirstResponder];
    [_account resignFirstResponder];
}

-(IBAction)loginVC:(id)sender{
    
    if (requestFlag)
        return;
    
    if ([self.account.text isEqualToString:@""] ||[self.account.text isEqualToString:nil]) {
        [Utils showToastWithText:@"账号不能为空"];
        return;
    }
    
    if ([self.password.text isEqualToString:@""] ||[self.password.text isEqualToString:nil]) {
        [Utils showToastWithText:@"密码不能为空"];
        return;
    }

    requestFlag = YES;
    [self showActivityView:self.view];
    
    [HttpLoginAction loginWithAccount:self.account.text password:self.password.text complete:^(id result, NSError *error) {
        
        int flag=[(NSNumber*)[result valueForKey:@"ResultFlag"]intValue];
        NSString *resultMsg=[result valueForKey:@"ResultMsg"];
        
        if (flag ==1) {
            
            [Utils showToastWithText:resultMsg];
            
            [[NSUserDefaults standardUserDefaults]setObject:UserDefaultEntity.account forKey:@"Account_name"];
            [[NSUserDefaults standardUserDefaults] setObject:self.password.text forKey:@"Account_pwd"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [Utils showToastWithText:resultMsg];
        }
        requestFlag=false;
        [self stopActivityView];
    }];
}

-(IBAction)registerBtn:(id)sender{
    JPRegisterViewController *registerVC=[self.storyboard instantiateViewControllerWithIdentifier:@"JPRegisterViewController"];
    registerVC.opType=@"register";
    [[ModulesManager defaultManager].navigationController pushViewController:registerVC animated:YES];
}

-(IBAction)forget:(id)sender{

    JPRegisterViewController *registerVC=[self.storyboard instantiateViewControllerWithIdentifier:@"JPRegisterViewController"];
    registerVC.opType=@"forget";
    [[ModulesManager defaultManager].navigationController pushViewController:registerVC animated:YES];
}


@end
