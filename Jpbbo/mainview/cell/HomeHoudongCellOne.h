//
//  HomeHoudongCellOne.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/6.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeHoudongCellOne;

@protocol HomeGoudongCellOneDelegate <NSObject>

-(void)dongOneCell:(HomeHoudongCellOne *)cell clickAtIndex:(NSInteger)index;

@end

@interface HomeHoudongCellOne : UITableViewCell

@property (nonatomic,weak) IBOutlet UIImageView *oneImageView;

@property (nonatomic,weak) id<HomeGoudongCellOneDelegate>delegate;

-(void)setCellValue:(NSArray*)dic;

@end
