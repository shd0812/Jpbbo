//
//  MenuView.m
//  JKSideSlipView
//
//  Created by Jakey on 15/1/10.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

+(instancetype)menuView{
    
    UIView *result = nil;

    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    for (id object in nibView){
        
        if ([object isKindOfClass:[self class]]){
            result = object;
            break;
        }
    }
    
    return result;
}


-(void)didSelectRowAtIndexPath:(void (^)(id cell, NSIndexPath *indexPath))didSelectRowAtIndexPath{
    _didSelectRowAtIndexPath = [didSelectRowAtIndexPath copy];
}

-(void)setItems:(NSMutableArray *)items{
    _items = items;
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
