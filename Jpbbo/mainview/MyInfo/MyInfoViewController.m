//
//  MyInfoViewController.m
//  JPbbo
//
//  Created by jpbbo on 15/7/3.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "MyInfoViewController.h"
#import "UserDefault.h"
#import "UIScrollView+MJRefresh.h"
#import "ServiceCode.h"
#import "UIImageView+WebCache.h"
#import "HttpLoginAction.h"
#import "ModifyPassViewController.h"
#import "ModifyInfoViewController.h"

@interface MyInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableListView;

@property (strong, nonatomic) NSArray *modules;
@property (nonatomic, strong) NSDictionary *titles;

@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的社区"];
    
    self.tabBarItem.title = @"我的社区";
    self.tabBarItem.image=[UIImage imageNamed:@"my_normal"];
    self.tabBarItem.selectedImage=[[UIImage imageNamed:@"my_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _tableListView.delegate = self;
    _tableListView.dataSource = self;
    
    NSString *path=[NSString stringWithFormat:@"%@%@",HOME_IMAGE_URL,UserDefaultEntity.headPath];
    [self.faceImageView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"oldman_03.png"]];
    
    self.modules = @[@[@"more_share"],@[@"more_repass",@"more_quit"]];
    self.titles = @{@"more_share":@"分享好友",
                    @"more_repass":@"修改密码",
                    @"more_quit":@"退出应用"};
    
    [_tableListView addHeaderWithTarget:self action:@selector(reloadUserInfo)];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSString *path=[NSString stringWithFormat:@"%@%@",HOME_IMAGE_URL,UserDefaultEntity.headPath];
    [self.faceImageView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"oldman_03.png"]];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //self.cornLabel.text=[NSString stringWithFormat:@"%@积分",UserDefaultEntity.vipCoin];
    self.cornLabel.text=[NSString stringWithFormat:@"%@积分",@"200"];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadUserInfo{
    
    [self.tableListView headerEndRefreshing];
}

-(BOOL)checkWhetherLogin{
    
    if (UserDefaultEntity.session_id.length) {
        return YES;
    }
    return NO;
}


#pragma mark - tableView
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.modules count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.modules objectAtIndex:section] count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentify = @"DefaultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    NSString *module = [[self.modules objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    cell.imageView.image = [UIImage imageNamed:module];
    cell.textLabel.text = [self.titles objectForKey:module];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *module = [[self.modules objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if ([module isEqualToString:@"more_share"]) {
        [self goForward];
    }else if ([module isEqualToString:@"more_quit"]){
        [self quitBtn];
    }else if([module isEqualToString:@"more_repass"]){
        ModifyPassViewController *modifyPass=[self.storyboard instantiateViewControllerWithIdentifier:@"ModifyPassViewController"];
        [[ModulesManager defaultManager].navigationController pushViewController:modifyPass animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
   
}


-(IBAction)changeMyInfo:(id)sender{
    ModifyInfoViewController *modifyInfo=[self.storyboard instantiateViewControllerWithIdentifier:@"ModifyInfoViewController"];
    [[ModulesManager defaultManager].navigationController pushViewController:modifyInfo animated:YES];
}

-(IBAction)MyOrderList:(id)sender{

}

-(IBAction)MyCornList:(id)sender{

}

-(void)quitBtn{
    
    [HttpLoginAction logoutComplete:^(id result, NSError *error) {
        if (error == nil) {
            [self.navigationController popViewControllerAnimated:YES];
            [Utils showToastWithText:@"退出登录成功"];
        }else {
            [Utils showToastWithText:@"对不起，退出登录失败！"];
        }
    }];
}

-(void)goForward{
    
    
}

@end
