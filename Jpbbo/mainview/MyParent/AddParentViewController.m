//
//  AddParentViewController.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/7.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "AddParentViewController.h"
#import "HttpParentAction.h"
#import "AddSeParentViewController.h"
#import "MyParents.h"

@interface AddParentViewController (){

    BOOL requestFlag;
}

@end

@implementation AddParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.type isEqualToString:@"add"]) {
        [self setTitle:@"我的父母－添加"];
    }else{
        [self setTitle:@"我的父母－修改"];
    }
    
    // Do any additional setup after loading the view.
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(0, 0, 60, 30);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0,25,0,0);
    //定义按钮标题字体格式
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    //给button添加委托方法，即点击触发的事件。
    [button addTarget:self action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    
    self.headImageView.layer.masksToBounds=YES;
    self.headImageView.layer.cornerRadius=self.headImageView.bounds.size.height/2;
    
    [self.headImageView setImage:[UIImage imageNamed:@"oldman_03.png"]];
    
    self.codeImageView.layer.masksToBounds=YES;
    self.codeImageView.layer.cornerRadius=self.codeImageView.bounds.size.height/2;
    [self.codeImageView setImage:[UIImage imageNamed:@"watch_03.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)saveBtn:(id)sender{

    if ([self.fristCodeTF.text isEqualToString:@""] ||[self.fristCodeTF.text isEqualToString:nil]) {
        [Utils showToastWithText:@"设备编码不能为空"];
        return;
    }
    
    if ([self.nameTF.text isEqualToString:@""] ||[self.nameTF.text isEqualToString:nil]) {
        [Utils showToastWithText:@"姓名不能为空"];
        return;
    }
    
    if ([self.numberTF.text isEqualToString:@""] ||[self.numberTF.text isEqualToString:nil]) {
        [Utils showToastWithText:@"身份证号不能为空"];
        return;
    }

    requestFlag = YES;
    [self showActivityView:self.view];

    [HttpParentAction addParentWatch:self.fristCodeTF.text UID:UserDefaultEntity.uid account:UserDefaultEntity.account number:self.numberTF.text name:self.nameTF.text complete:^(id result, NSError *error) {
        int flag=[(NSNumber*)[result valueForKey:@"ResultFlag"]intValue];
        NSString *resultMsg=[result valueForKey:@"ResultMsg"];
        
        if (flag ==1) {
            [Utils showToastWithText:resultMsg];
            
            NSDictionary *dict=[result valueForKey:@"ResultData"];
            MyParents *myparents=[[MyParents alloc]init];
            if ([[dict allKeys] containsObject:@"ID"]) {
                
                myparents.ID=[dict valueForKey:@"ID"];
                myparents.IMEI=self.fristCodeTF.text;
                myparents.IdentityNumber=self.numberTF.text;
                myparents.PhoneNumber=[dict valueForKey:@"PhoneNumber"];
                myparents.Sex=[(NSNumber*)[dict valueForKey:@"Sex"]intValue];
                myparents.Step=[dict valueForKey:@"Step"];
                myparents.Weight=[dict valueForKey:@"Weight"];
                myparents.Status=[dict valueForKey:@"Status"];
                myparents.Height=[dict valueForKey:@"Height"];
                myparents.EntityState=[dict valueForKey:@"EntityState"];
                myparents.CustomerName=self.nameTF.text;
                
                myparents.NowAddress=[dict valueForKey:@"NowAddress"];
                myparents.PhotoParth=[dict valueForKey:@"PhotoParth"];
                myparents.Birthday=[dict valueForKey:@"Birthday"];
                myparents.NickName=[dict valueForKey:@"Relationship"];
                //myparents.Longitude=[(NSNumber*)[dict valueForKey:@""]floatValue];
                //myparents.Latitude=[(NSNumber*)[dict valueForKey:@""]floatValue];
            }
            
            AddSeParentViewController *addSeParentVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AddSeParentViewController"];
            addSeParentVC.myparents=myparents;
            [[ModulesManager defaultManager].navigationController pushViewController:addSeParentVC animated:YES];
            //[self.navigationController popViewControllerAnimated:YES];
            
        }else if (flag ==2){
            [Utils showToastWithText:resultMsg];
            
            MyParents *myparents=[[MyParents alloc]init];
            
            myparents.IMEI=self.fristCodeTF.text;
            myparents.IdentityNumber=self.numberTF.text;
            myparents.CustomerName=self.nameTF.text;
            
            AddSeParentViewController *addSeParentVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AddSeParentViewController"];
            addSeParentVC.myparents=myparents;
            [[ModulesManager defaultManager].navigationController pushViewController:addSeParentVC animated:YES];
        }else{
            [Utils showToastWithText:resultMsg];
        }
        requestFlag=false;
        [self stopActivityView];
    }];
}

- (int)convertToInt:(NSString*)strtemp {
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    
    int result = (strlength+1)/2;
    return result;
}

-(IBAction)getHeadImage:(id)sender{

}

-(IBAction)scanCode:(id)sender{

}

@end
