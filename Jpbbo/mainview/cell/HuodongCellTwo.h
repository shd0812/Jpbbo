//
//  HuodongCellTwo.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/2.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HuodongCellTwo;

@protocol HuodongCellTwoDelegate <NSObject>

-(void)dongCell:(HuodongCellTwo *)cell clickAtIndex:(NSInteger)index;

@end

@interface HuodongCellTwo : UITableViewCell


@property (nonatomic,weak) IBOutlet UIImageView *dongImageView1;
@property (nonatomic,weak) IBOutlet UIImageView *dongImageView2;

@property (nonatomic,weak) IBOutlet UILabel *nameLabel1;
@property (nonatomic,weak) IBOutlet UILabel *nameLabel2;

@property (nonatomic,weak) IBOutlet UILabel *dongPrice1;
@property (nonatomic,weak) IBOutlet UILabel *dongPrice2;

@property (nonatomic,weak) IBOutlet UILabel *truePrice1;
@property (nonatomic,weak) IBOutlet UILabel *truePrice2;

@property (weak,nonatomic) id<HuodongCellTwoDelegate>delegate;

-(void)updateData:(NSMutableArray*)array;

@end
