//
//  PedometerViewController.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/10.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "PedometerViewController.h"
#import "HttpParentAction.h"
#import "helpDefine.h"
#import "UIView+Frame.h"

@interface PedometerViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) IBOutlet UITableView *tableView;

@property (nonatomic,strong) IBOutlet UISwitch *setSwitch;
@property (nonatomic,strong) IBOutlet UITextField *dateTextField;
@property (nonatomic,strong) IBOutlet UITextField *jibuTextField;

@property (nonatomic,strong) UIDatePicker *datePicker;


@end

@implementation PedometerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"计步器配置"];
    // Do any additional setup after loading the view.
    
    [self loadData];
    
    [_setSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtn:)];
    
    [self setTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTextField{
    self.dateTextField.delegate=self;
    self.jibuTextField.delegate=self;
    
    self.dateTextField.tag=1001;
    
    self.jibuTextField.returnKeyType=UIReturnKeyDone;
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.datePicker.minuteInterval = 30;
    [self.datePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)loadData{

    [HttpParentAction getPedometerDetail:UserDefaultEntity.equipmentId complete:^(id result, NSError *error) {
        NSDictionary *dict=[result objectForKey:@"ResultData"];
        
        if (error !=nil) {
            [Utils showToastWithText:@"数据异常请重新获取"];
        }else{
            
            int type=[(NSNumber*)[dict objectForKey:@"Switch"]intValue];
            if (type==1) {
                _setSwitch.on=YES;
                
                self.dateTextField.enabled=YES;
                self.jibuTextField.enabled=YES;
            }else{
                _setSwitch.on=NO;
                
                self.dateTextField.enabled=NO;
                self.jibuTextField.enabled=NO;
            }
            
            self.dateTextField.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"MovementUpTime"]];
            self.jibuTextField.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"Target"]];
        }
    }];
}

- (void)chooseDate:(UIDatePicker *)sender {
    NSDate *selectedDate = sender.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateString = [formatter stringFromDate:selectedDate];
    self.dateTextField.text = dateString;
}

-(IBAction)switchAction:(id)sender{

    if (self.setSwitch.on) {
        self.dateTextField.enabled=YES;
        self.jibuTextField.enabled=YES;
    } else {
        self.dateTextField.enabled=NO;
        self.jibuTextField.enabled=NO;
    }
}

-(IBAction)saveBtn:(id)sender{

    NSInteger switch_int;
    if (self.setSwitch.on) {
        switch_int=1;
    }else{
        self.dateTextField.text=@"";
        self.jibuTextField.text=@"";
        switch_int=0;
    }
    [HttpParentAction addPedometerSet:UserDefaultEntity.uid EID:UserDefaultEntity.equipmentId Switch:switch_int MovementUpTime:self.dateTextField.text Target:self.jibuTextField.text complete:^(id result, NSError *error) {
        
        NSInteger flag=[(NSNumber*)[result objectForKey:@"ResultFlag"]integerValue];
        NSString *resultMsg=[result objectForKey:@"ResultMsg"];
        if (flag==1) {
            [Utils showToastWithText:resultMsg];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [Utils showToastWithText:resultMsg];
        }
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    //如果当前要显示的键盘，那么把UIDatePicker（如果在视图中）隐藏
    if (textField.tag != 1001) {
        if (self.datePicker.superview) {
            [self.datePicker removeFromSuperview];
        }
        return YES;
    }
    
    //UIDatePicker以及在当前视图上就不用再显示了
    if (self.datePicker.superview == nil) {
        //close all keyboard or data picker visible currently
        [self.jibuTextField resignFirstResponder];
        
        //此处将Y坐标设在最底下，为了一会动画的展示
        self.datePicker.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 216);
        [self.view addSubview:self.datePicker];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.datePicker.height=self.datePicker.bottom;

        [UIView commitAnimations];
    }
    
    return NO;
}

@end
