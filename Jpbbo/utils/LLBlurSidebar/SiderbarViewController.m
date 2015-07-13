//
//  SiderbarViewController.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/8.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "SiderbarViewController.h"

#import "MenuCell.h"
#import "TitleCell.h"
#import "SendCell.h"
#import "helpDefine.h"

@interface SiderbarViewController ()<UITableViewDelegate, UITableViewDataSource,SendCellDelegate>

@end

@implementation SiderbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 列表
    if (SCREEN_HEIGHT>480) {
        self.myTableView = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    }else{
        self.myTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.78)];
    }

    [self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    [self.contentView addSubview:self.myTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark tableView Delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict=[_items objectAtIndex:indexPath.row];
    NSInteger type=[(NSNumber*)[dict objectForKey:@"type"]integerValue];
    
    if (type==2 ) {
        return 70;
    }
    
    if (type==4) {
        return 30;
    }
    
    return 48;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_didSelectRowAtIndexPath) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        _didSelectRowAtIndexPath(cell,indexPath);
    }
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)didSelectRowAtIndexPath:(void (^)(id cell, NSIndexPath *indexPath))didSelectRowAtIndexPath{
    _didSelectRowAtIndexPath = [didSelectRowAtIndexPath copy];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = self.items[indexPath.row];
    NSInteger type=[(NSNumber*)[dict objectForKey:@"type"]integerValue];
    
    if (type ==1 || type ==3 ||type ==5 ) {
        
        [self.myTableView registerNib:[UINib nibWithNibName:@"TitleCell" bundle:nil] forCellReuseIdentifier:@"TitleCell"];
        TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell"];
        cell.lable.text = [dict objectForKey:@"title"];
        cell.icon.image = [UIImage imageNamed:[dict objectForKey:@"imagename"]];
        return cell;
        
    }
    
    if (type ==2 ) {
        [self.myTableView registerNib:[UINib nibWithNibName:@"SendCell" bundle:nil] forCellReuseIdentifier:@"SendCell"];
        SendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SendCell"];
        
        return cell;
    }
    
    if (type ==4) {
        
        [self.myTableView registerNib:[UINib nibWithNibName:@"MenuCell" bundle:nil] forCellReuseIdentifier:@"MenuCell"];
        MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
        cell.lable.text = [dict objectForKey:@"title"];
        cell.icon.image = [UIImage imageNamed:[dict objectForKey:@"imagename"]];
        
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}

-(void)clickCell:(SendCell *)cell clickAtIndex:(NSInteger)index{
    
}


@end
