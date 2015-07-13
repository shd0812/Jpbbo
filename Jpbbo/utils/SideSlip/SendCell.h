//
//  SendCell.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/8.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SendCell;

@protocol SendCellDelegate <NSObject>

-(void)clickCell:(SendCell *)cell clickAtIndex:(NSInteger)index;

@end

@interface SendCell : UITableViewCell

@property (nonatomic,weak) id<SendCellDelegate>delegate;

@end
