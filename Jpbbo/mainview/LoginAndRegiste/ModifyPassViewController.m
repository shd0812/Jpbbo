//
//  ModifyPassViewController.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/9.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "ModifyPassViewController.h"
#import "HttpLoginAction.h"

@interface ModifyPassViewController (){
    BOOL requestFlag;
}

@end

@implementation ModifyPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.submitBtn.layer setMasksToBounds:YES];
    [self.submitBtn.layer setCornerRadius:5.0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)submitBtn:(id)sender{
    
    if ([self.oldpass.text isEqualToString:@""] ||[self.oldpass.text isEqualToString:nil]) {
        [Utils showToastWithText:@"老密码不能为空"];
        return;
    }
    
    if ([self.newpass.text isEqualToString:@""] ||[self.newpass.text isEqualToString:nil]) {
        [Utils showToastWithText:@"新密码不能为空"];
        return;
    }
    
    if (![self.newpass.text isEqualToString:self.repass.text]) {
        [Utils showToastWithText:@"密码不一致"];
        return;
    }

    requestFlag = YES;
    [self showActivityView:self.view];
    
    [HttpLoginAction modifyPass:UserDefaultEntity.account oldPass:self.oldpass.text newPass:self.newpass.text UID:UserDefaultEntity.uid complete:^(id result, NSError *error) {
        
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
