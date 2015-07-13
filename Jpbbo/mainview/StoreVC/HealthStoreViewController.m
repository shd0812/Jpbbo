//
//  HealthStoreViewController.m
//  JPbbo
//
//  Created by jpbbo on 15/7/3.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "HealthStoreViewController.h"
#import "SetHongdongCell.h"
#import "GuanggaoCell.h"
#import "UIScrollView+MJRefresh.h"
#import "CycleScrollView.h"
#import "helpDefine.h"
#import "AdvertiseViewController.h"

@interface HealthStoreViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *funList;

@property (strong, nonatomic) CycleScrollView *adsView;
@property (retain, nonatomic) NSArray *adsArray;

@end

@implementation HealthStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"健康商城"];
    
    self.tabBarItem.title = @"健康商城";
    self.tabBarItem.image=[UIImage imageNamed:@"store_normal"];
    self.tabBarItem.selectedImage=[[UIImage imageNamed:@"store_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    if (_funList==nil) {
        _funList=[[NSMutableArray alloc]init];
    }
   
    [self.tableView setBackgroundColor:[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1]];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView addHeaderWithTarget:self action:@selector(reloadData)];
    [self.view addSubview:_tableView];
    
    //广告：定时器广告图片切换
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (100.0) * SCREEN_WSCALE)];
    {
        __weak HealthStoreViewController *weakSelf=self;
        self.adsView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100.0 * SCREEN_WSCALE) animationDuration:3];
        
        [_adsView setFetchContentViewAtIndex:^UIView *(NSInteger pageIndex){
            if (pageIndex < [weakSelf.adsArray count]) {
                if (pageIndex == 0) {
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100.9 * SCREEN_WSCALE)];
                    
                    NSString *url= @"";
                    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"banner_02.png"]];
                    
                    return imageView;
                }else if(pageIndex == 1){
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100.9 * SCREEN_WSCALE)];
                    
                    NSString *url= @"";
                    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"banner00_02.png"]];
                    
                    return imageView;
                }else if(pageIndex == 2){
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100.9 * SCREEN_WSCALE)];
                    
                    NSString *url= @"";
                    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"banner03_02.png"]];
                    
                    return imageView;
                }
            }
            /**
             if (pageIndex < [weakSelf.adsArray count]) {
             NSDictionary *dict=[weakSelf.adsArray objectAtIndex:pageIndex];
             UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150.9 * SCREEN_WSCALE)];
             NSString *name=[dict objectForKey:@"img"];
             NSString *url= [NSString stringWithFormat:@"%@",name];
             
             [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon.png"]];
             
             return imageView;
             }**/
            return [[UIView alloc] initWithFrame:CGRectZero];
        }];
        
        [_adsView setTapActionBlock:^(NSInteger pageIndex){
            if (pageIndex <[weakSelf.adsArray count]) {
                AdvertiseViewController *advertiseVC=[weakSelf.storyboard instantiateViewControllerWithIdentifier:@"AdvertiseViewController"];
                advertiseVC.type=@"guanggao";
                [[ModulesManager defaultManager].navigationController pushViewController:advertiseVC animated:YES];
            }
        }];
        [headerView addSubview:_adsView];
    }
    
    self.tableView.tableHeaderView = headerView;
    
    [self setExtraCellLineHidden:_tableView];
    
    [self loadData];
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

-(void)loadData{

    NSArray *buildList=@[@"1",@"2",@"3"];
    self.adsArray = buildList;
    [_adsView setTotalPagesCount:^NSInteger{
        return [buildList count];
    }];
    
    NSMutableArray *item=[[NSMutableArray alloc]init];
    
    [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                     @"金牌保镖钻石卡套餐",@"title",
                     @"热销中",@"status",
                     @"¥1999",@"price",
                     @"diamond_10.png",@"img",nil]];
    [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                     @"金牌保镖白金卡套餐",@"title",
                     @"热销中",@"status",
                     @"¥1799",@"price",
                     @"slivercard_08.png",@"img",nil]];
    [item addObject:[[NSDictionary alloc]initWithObjectsAndKeys:
                     @"金牌保镖金卡套餐",@"title",
                     @"热销中",@"status",
                     @"¥1699",@"price",
                     @"goldcard_05.png",@"img",nil]];
    
    _funList=item;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_funList count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=[_funList objectAtIndex:indexPath.row];
    
    SetHongdongCell *cell = (SetHongdongCell*)[tableView dequeueReusableCellWithIdentifier:@"SetHongdongCell"];
    if (cell == nil) {
        NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:@"SetHongdongCell" owner:self options:nil];
        for (id oneObject in nibs) {
            if ([oneObject isKindOfClass:[SetHongdongCell class]]) {
                cell = (SetHongdongCell *)oneObject;
                //cell.delegate = self;
            }
        }
    }
    
    [cell.setImageView setImage:[UIImage imageNamed:[dict objectForKey:@"img"]]];
    cell.statusLabel.text=[dict objectForKey:@"status"];
    cell.priceLabel.text=[dict objectForKey:@"price"];
    cell.titleLabel.text=[dict objectForKey:@"title"];
    cell.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
