//
//  AddSeParentViewController.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/9.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "AddSeParentViewController.h"
#import "helpDefine.h"
#import "HttpParentAction.h"
#import "dateView.h"


@interface AddSeParentViewController ()<UITextFieldDelegate,date_protocol_Delegate>{
    BOOL requestFlag;
     NSString *birthdayStr;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *modules;
@property (nonatomic, strong) NSDictionary *titles;
@property (nonatomic, strong) NSMutableDictionary *values;

@property (strong,nonatomic) NSString *sex_str;

@property (assign, nonatomic) BOOL state;

@end

@implementation AddSeParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"完善信息"];
    // Do any additional setup after loading the view.
    
    _sex_str=self.myparents.Sex == 1?@"男":@"女";
    
    self.sexTF.tag = 1001;
    self.brithTF.tag = 1002;
    
    self.brithTF.delegate = self;
    self.sexTF.delegate = self;
    
    self.nickTF.delegate=self;
    self.phoneTF.delegate=self;
    self.stepTF.delegate = self;
    self.weigtTF.delegate = self;
    self.heigthTF.delegate=self;
    
    self.nickTF.returnKeyType = UIReturnKeyDone;
    self.phoneTF.returnKeyType = UIReturnKeyDone;
    self.brithTF.returnKeyType = UIReturnKeyDone;
    self.weigtTF.returnKeyType = UIReturnKeyDone;
    self.heigthTF.returnKeyType = UIReturnKeyDone;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtn:)];
    
    [self loadDataView];
}

-(void)loadDataView{
    
    self.sexTF.text=_sex_str;
    NSLog(@"昵称：%@",self.myparents.NickName);
    if (self.myparents.NickName==nil) {
        self.myparents.NickName=[NSString stringWithFormat:@""];
    }
    self.nickTF.text=[NSString stringWithFormat:@"%@",self.myparents.NickName];
    self.phoneTF.text=[NSString stringWithFormat:@"%@",self.myparents.PhoneNumber];
    self.brithTF.text=[NSString stringWithFormat:@"%@",self.myparents.Birthday];
    self.heigthTF.text=[NSString stringWithFormat:@"%@",self.myparents.Height];
    self.weigtTF.text=[NSString stringWithFormat:@"%@",self.myparents.Weight];
    self.stepTF.text=[NSString stringWithFormat:@"%@",self.myparents.Step];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag ==1001) {
        [BlockActionSheet showActionSheetWithTitle:@"性别" block:^(BlockActionSheet *clickView, int index) {
            NSString *title = [clickView buttonTitleAtIndex:index];
            if ([title isEqualToString:@"男"]) {
                self.sexTF.text = title;
            }else if ([title isEqualToString:@"女"]) {
                self.sexTF.text = title;
            }
            _sex_str=title;
        } cancelButtonTitle:@"取消" otherButtonTitles:@"男",@"女", nil];
        
        return NO;
    }
    
    //如果当前要显示的键盘，那么把UIDatePicker（如果在视图中）隐藏
    if (textField.tag == 1002) {
        if (_state == NO) {
            
            NSArray *ArrView = [[NSBundle mainBundle]loadNibNamed:@"dateView" owner:self options:nil];
            dateView *view = [ArrView objectAtIndex:0];
            view.frame = CGRectMake(0, 270, 320, 250);
            [_tableView addSubview:view];
            _state = YES;
            view.date_delegate = self;
        }
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

    return YES;
}

-(void)date:(NSString *)dateStr{
    self.brithTF.text =dateStr;
    _state = NO;
}

-(IBAction)saveBtn:(id)sender{
    
    if ([self.nickTF.text isEqualToString:@""] ||[self.nickTF.text isEqualToString:nil]) {
        [Utils showToastWithText:@"昵称不能为空"];
        return;
    }
    
    if ([self.phoneTF.text isEqualToString:@""] ||[self.phoneTF.text isEqualToString:nil]) {
        [Utils showToastWithText:@"设备手机号不能为空"];
        return;
    }

    if ([self.brithTF.text isEqualToString:@""] ||[self.brithTF.text isEqualToString:nil]) {
        [Utils showToastWithText:@"出生年月日不能为空"];
        return;
    }
    
    if ([self.heigthTF.text isEqualToString:@""] ||[self.heigthTF.text isEqualToString:nil]) {
        [Utils showToastWithText:@"身高不能为空"];
        return;
    }
    
    if ([self.weigtTF.text isEqualToString:@""] ||[self.weigtTF.text isEqualToString:nil]) {
        [Utils showToastWithText:@"体重不能为空"];
        return;
    }
    
    if ([self.stepTF.text isEqualToString:@""] ||[self.stepTF.text isEqualToString:nil]) {
        [Utils showToastWithText:@"步长不能为空"];
        return;
    }
    
    requestFlag = YES;
    [self showActivityView:self.view];
    NSString *sex;
    if([_sex_str isEqualToString:@"男"]){
        sex=@"1";
    }else{
        sex=@"0";
    }
    
    [HttpParentAction addSeParentWatch:self.myparents.IMEI account:UserDefaultEntity.account UID:UserDefaultEntity.uid number:self.myparents.IdentityNumber name:self.myparents.CustomerName PhoneNumber:self.phoneTF.text Birthday:self.brithTF.text Sex:sex Height:self.heigthTF.text Weight:self.weigtTF.text Step:self.stepTF.text Relationship:self.nickTF.text complete:^(id result, NSError *error) {
        
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
