//
//  JPRateViewController.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/10.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "JPRateViewController.h"
#import "HttpParentAction.h"

@interface JPRateViewController ()

@property (nonatomic,strong) IBOutlet UITableView *tableView;

@property (nonatomic,strong) IBOutlet UISwitch *dateSwitch;
@property (nonatomic,strong) IBOutlet UISwitch *warnSwitch;

@property (nonatomic,strong) IBOutlet UITextField *dateTextField;
@property (nonatomic,strong) IBOutlet UITextField *upTextField;
@property (nonatomic,strong) IBOutlet UITextField *downTextField;

@end

@implementation JPRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"心率配置"];
    // Do any additional setup after loading the view.
    
    [self loadData];
    _dateSwitch.on=NO;
    _warnSwitch.on=NO;
    [_dateSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [_warnSwitch addTarget:self action:@selector(warnAction:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtn:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    [HttpParentAction getRateDetail:UserDefaultEntity.equipmentId complete:^(id result, NSError *error) {
    
        NSDictionary *dict=[result objectForKey:@"ResultData"];
        
        if (error !=nil) {
            [Utils showToastWithText:@"数据异常请重新获取"];
        }else{
            
            int type=[(NSNumber*)[dict objectForKey:@"Switch"]intValue];
            if (type==1) {
                _dateSwitch.on=YES;
                
                self.dateTextField.enabled=YES;
                self.warnSwitch.enabled=YES;
                
                NSInteger worn_int=[(NSNumber*)[dict objectForKey:@"WhetherWarning"]integerValue];
                if (worn_int==1) {
                    _warnSwitch.on=YES;
                    self.upTextField.enabled=YES;
                    self.downTextField.enabled=YES;
                }else{
                    self.upTextField.enabled=NO;
                    self.downTextField.enabled=NO;
                }
            }else{
                _dateSwitch.on=NO;
                self.dateTextField.enabled=NO;
                self.warnSwitch.enabled=NO;
                
                _warnSwitch.on=NO;
                self.upTextField.enabled=NO;
                self.downTextField.enabled=NO;
            }
            
            self.dateTextField.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"HeartRateUpTime"]];
            self.upTextField.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"HeartrateTop"]];
            self.downTextField.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"HeartrateLower"]];
        }

    }];
}

-(IBAction)switchAction:(id)sender{
    if (self.dateSwitch.on) {
        self.dateTextField.enabled=YES;
        self.warnSwitch.enabled=YES;
    } else {
        _warnSwitch.on=NO;
        self.dateTextField.enabled=NO;
        self.warnSwitch.enabled=NO;
        self.upTextField.enabled=NO;
        self.downTextField.enabled=NO;
    }
}

-(IBAction)warnAction:(id)sender{
    if (self.warnSwitch.on) {
        self.upTextField.enabled=YES;
        self.downTextField.enabled=YES;
    } else {
        self.upTextField.enabled=NO;
        self.downTextField.enabled=NO;
    }
}

-(IBAction)saveBtn:(id)sender{
    
    NSInteger switch_int;
    if (self.dateSwitch.on) {
        switch_int=1;
    }else{
        self.dateTextField.text=@"";
        switch_int=0;
    }
    NSInteger worn_int;
    if (self.warnSwitch.on) {
        worn_int=1;
    }else{
        self.upTextField.text=@"";
        self.downTextField.text=@"";
        worn_int=0;
    }
    
    [HttpParentAction addRateSet:UserDefaultEntity.uid EID:UserDefaultEntity.equipmentId Switch:switch_int HeartRateUpTime:self.dateTextField.text WhetherWarning:worn_int HeartrateTop:self.upTextField.text HeartrateLower:self.downTextField.text complete:^(id result, NSError *error) {
        
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

@end
