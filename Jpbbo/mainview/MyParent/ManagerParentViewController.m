//
//  ManagerParentViewController.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/8.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "ManagerParentViewController.h"
#import "AddParentViewController.h"
#import "ContactParentCell.h"
#import "SWTableViewCell.h"
#import "HttpParentAction.h"
#import "ServiceCode.h"
#import "MyParents.h"
#import "RMMapper.h"

@interface ManagerParentViewController ()<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>{
    BOOL requestFlag;
}

@property (nonatomic,strong) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *funList;

@end

@implementation ManagerParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"设备管理"];
    
    if (_funList == nil) {
        _funList=[[NSMutableArray alloc]init];
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(0, 0, 24, 24);
    [button setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,0);

    //给button添加委托方法，即点击触发的事件。
    [button addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    //_tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self.tableView setBackgroundColor:[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1]];
    
    [self loadTableView];
    
    [self setExtraCellLineHidden:_tableView];
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

- (NSArray *)rightButtons{
    
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    /**[rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"设为默认"];**/
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"取消关联"];
    
    return rightUtilityButtons;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *dic = [_funList objectAtIndex:indexPath.row];
    
    NSString *EID=[NSString stringWithFormat:@"%@",[dic valueForKey:@"ID"]];
    [self addressDelete:EID];

    [_funList removeObjectAtIndex:indexPath.row];
    
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
}


-(void)addressDelete:(NSString*) eid{
    
    requestFlag = YES;
    [self showActivityView:self.view];
    
    [HttpParentAction deleteRelate:eid UID:UserDefaultEntity.uid complete:^(id result, NSError *error) {
        int flag=[(NSNumber*)[result valueForKey:@"ResultFlag"]intValue];
        NSString *resultMsg=[result valueForKey:@"ResultMsg"];
        if(flag==1){
            [Utils showToastWithText:resultMsg];
        }else{
            [Utils showToastWithText:resultMsg];
        }
        requestFlag=false;
        [self stopActivityView];
    }];
}

-(void)addressSetDefault:(NSString*) aid{

}

-(void)loadTableView{
    
    requestFlag = YES;
    [self showActivityView:self.view];
    
    [HttpParentAction getManagerSetList:UserDefaultEntity.uid complete:^(id result, NSError *error) {
 
        if (result) {
            NSArray *returnArray=result;
            _funList=[[NSMutableArray alloc]initWithArray: [RMMapper arrayOfClass:[MyParents class] fromArrayOfDictionary:returnArray]];
            
            [self.tableView reloadData];
        }
        requestFlag=false;
        [self stopActivityView];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_funList count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyParents *myparents=[_funList objectAtIndex:indexPath.row];
    
    [tableView registerNib:[UINib nibWithNibName:@"ContactParentCell" bundle:nil] forCellReuseIdentifier:@"ContactParentCell"];
    ContactParentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactParentCell"];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",HOME_IMAGE_URL,myparents.PhotoParth];
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"oldman_03.png"]];
    [cell.nameLabel setText:myparents.CustomerName];
    [cell.watchImageView setImage:[UIImage imageNamed:@"watch_03.png"]];
    
    [cell setRightUtilityButtons: [self rightButtons]];
    cell.delegate = self;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // NSDictionary *dict=[_funList objectAtIndex:indexPath.row];
   /**
    AddParentViewController *addParentVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AddParentViewController"];
    
    addParentVC.type=@"modfify";
    
    [[ModulesManager defaultManager].navigationController pushViewController:addParentVC animated:YES];**/
}

-(IBAction)addBtn:(id)sender{

    AddParentViewController *addParentVC=[self.storyboard instantiateViewControllerWithIdentifier:@"AddParentViewController"];
    addParentVC.type=@"add";
    [[ModulesManager defaultManager].navigationController pushViewController:addParentVC animated:YES];
}

@end
