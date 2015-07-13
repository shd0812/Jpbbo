//
//  ModifyInfoViewController.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/9.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "ModifyInfoViewController.h"
#import "InfoTableViewCell.h"
#import "HeadFaceCell.h"
#import "dateView.h"
#import "HttpLoginAction.h"

extern BOOL isEdit;
@interface ModifyInfoViewController ()<UITableViewDelegate,UITableViewDataSource,InfoTableViewCellDelegate,HeadFaceCellDelegate,date_protocol_Delegate>{
    NSString *birthdayStr;
    BOOL requestFlag;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *modules;
@property (nonatomic, strong) NSDictionary *titles;
@property (nonatomic, strong) NSMutableDictionary *values;

@property (nonatomic) BOOL edited;
@property (strong,nonatomic) NSString *sex_str;

@property (assign, nonatomic) BOOL state;

@end

static UIDatePicker *date;
@implementation ModifyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的账号"];
    // Do any additional setup after loading the view.
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    self.modules = @[@[@"info_head",@"info_nick",@"info_rank"],@[@"info_name",@"info_sex",@"info_birthday"],@[@"info_email",@"info_mobile"]];
    self.titles = @{@"info_head":@"头像",
                    @"info_nick":@"昵称",
                    @"info_rank":@"会员等级",
                    
                    @"info_name":@"姓名",
                    @"info_sex":@"性别",
                    @"info_birthday":@"生日",
                    
                    @"info_email":@"邮箱",
                    @"info_mobile":@"电话"};
    
    //NSLog(@"sex:%@",UserDefaultEntity.sex);
    NSString *brith=UserDefaultEntity.birDate;
    NSString *brith2 = [brith substringToIndex:10];
    self.values = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                   UserDefaultEntity.nickName?UserDefaultEntity.nickName:@"",@"info_nick",
                   UserDefaultEntity.refOneName?UserDefaultEntity.refOneName:@"",@"info_recommend",
                   UserDefaultEntity.realName?UserDefaultEntity.realName:@"",@"info_name",
                   [UserDefaultEntity.sex intValue] == 1?@"男":@"女",@"info_sex",
                   brith2,@"info_birthday",
                   UserDefaultEntity.mailAdd?UserDefaultEntity.mailAdd:@"",@"info_email",
                   UserDefaultEntity.telePhone?UserDefaultEntity.telePhone:@"",@"info_mobile",nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction:)];
    
    [self setExtraCellLineHidden:_tableView];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //[_faceImageView setImage:[UIImage imageNamed:@"oldman_03.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.modules count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.modules objectAtIndex:section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *module = [[self.modules objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([module isEqualToString:@"info_head"]) {
        return 50;
    }
    return 36;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSString *module = [[self.modules objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if ([module isEqualToString:@"info_head"]) {
        HeadFaceCell *cell = (HeadFaceCell*)[tableView dequeueReusableCellWithIdentifier:@"HeadFaceCell"];
        if (cell == nil) {
            NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:@"HeadFaceCell" owner:self options:nil];
            for (id oneObject in nibs) {
                if ([oneObject isKindOfClass:[HeadFaceCell class]]) {
                    cell = (HeadFaceCell *)oneObject;
                    cell.delegate = self;
                }
            }
        }
        cell.tag = indexPath.row;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.faceImageView setImage:[UIImage imageNamed:@"oldman_03.png"]];
        
        return cell;
    }
    
    NSString *cellIdentify = @"DefaultCell";
    
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:@"InfoTableViewCell" owner:self options:nil];
        for (id oneObject in nibs) {
            if ([oneObject isKindOfClass:[InfoTableViewCell class]]) {
                cell = (InfoTableViewCell *)oneObject;
                cell.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
        }
        
    }
   
    cell.nameLabel.text = [self.titles objectForKey:module];
    cell.contentTF.text = [self.values objectForKey:module];
    //NSLog(@"数据：%@",[self.values objectForKey:module]);
    cell.cellKey = module;
    
    return cell;
}

- (BOOL)userInfoEditCellShouldBeginEidting:(InfoTableViewCell *)cell {
    if (self.edited) {
        if ([cell.cellKey isEqualToString:@"info_recommend"]) {
            NSString* val = [self.values valueForKey:@"info_recommend"];
            if ([val isEqualToString:@""] || [val isEqualToString:@"4008609519"]) {
                return YES;
            }
            return NO;
        }
        if ([cell.cellKey isEqualToString:@"info_sex"]) {
            [BlockActionSheet showActionSheetWithTitle:@"性别" block:^(BlockActionSheet *clickView, int index) {
                NSString *title = [clickView buttonTitleAtIndex:index];
                if ([title isEqualToString:@"男"]) {
                    cell.contentTF.text = title;
                }else if ([title isEqualToString:@"女"]) {
                    cell.contentTF.text = title;
                }
                _sex_str=title;
            } cancelButtonTitle:@"取消" otherButtonTitles:@"男",@"女", nil];
            
            return NO;
        }
        /**
        if ([cell.cellKey isEqualToString:@"info_birthday"]) {
            
            if (_state == NO) {
                
                NSArray *ArrView = [[NSBundle mainBundle]loadNibNamed:@"dateView" owner:self options:nil];
                dateView *view = [ArrView objectAtIndex:0];
                view.frame = CGRectMake(0, 270, 320, 250);
                [_tableView addSubview:view];
                _state = YES;
                view.date_delegate = self;
                
                cell.contentTF.text = birthdayStr;
            }
            return NO;
        }**/
        return YES;
    }
    return NO;
}

-(void)date:(NSString *)dateStr{
    
    birthdayStr = dateStr;
    NSLog(@"生日是 %@",birthdayStr);
    //[_dateBtn setTitle:dateStr forState:UIControlStateNormal];
    _state = NO;
}

- (void)userInfoEditCellDidEndEditing:(InfoTableViewCell *)cell {
    [self.values setObject:cell.contentTF.text forKey:cell.cellKey];
    if ([cell.cellKey isEqualToString:@"info_recommend"]) {
        UserDefaultEntity.refOneName = cell.contentTF.text;
        [UserDefault saveUserDefault];
    }
}

-(IBAction)editAction:(id)sender{
    if (self.edited == NO) {
        self.edited = !self.edited;
        self.navigationItem.rightBarButtonItem.title = @"完成";
    }else {
        [self resignFirstResponder];
        
        self.navigationItem.rightBarButtonItem.enabled = NO;
        __weak ModifyInfoViewController *weakSelf = self;
        
        requestFlag = YES;
        [self showActivityView:self.view];
        
        [HttpLoginAction modifyInfo:UserDefaultEntity.uid account:UserDefaultEntity.account Nickname:[self.values objectForKey:@"info_nick"] TrueName:[self.values objectForKey:@"info_name"] SexID:[_sex_str isEqualToString:@"男"]?@"1":@"0" Birthday:[self.values objectForKey:@"info_birthday"] Mail:[self.values objectForKey:@"info_email"] Tel:[self.values objectForKey:@"info_mobile"] complete:^(id result, NSError *error) {
            
            requestFlag=false;
            [self stopActivityView];
            
            int flag=[(NSNumber*)[result valueForKey:@"ResultFlag"]intValue];
            NSString *resultMsg=[result valueForKey:@"ResultMsg"];
            
            if (flag ==1) {
                self.edited = !self.edited;
                [Utils showToastWithText:resultMsg];
                
                weakSelf.navigationItem.rightBarButtonItem.title = @"编辑";
            }else{
                [Utils showToastWithText:resultMsg];
                self.navigationItem.rightBarButtonItem.title = @"完成";
            }
            weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
        }];
    }
}

-(IBAction)changeBtn:(id)sender{

}

-(void)selectHeader:(HeadFaceCell*)cell index:(NSInteger)idndex{
   [Utils showAlertView:@"提示" :@"功能暂时没有做上，请稍后……" :@"知道了"];
}

@end
