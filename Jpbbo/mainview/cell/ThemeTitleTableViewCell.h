//
//  ThemeTitleTableViewCell.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/2.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ThemeTitleTableViewCell;

@protocol ThemeTitleTableViewCellDelegate <NSObject>

-(void)clickSubject:(ThemeTitleTableViewCell*)cell index:(NSInteger)index;

@end

@interface ThemeTitleTableViewCell : UITableViewCell

@property (strong,nonatomic) id<ThemeTitleTableViewCellDelegate> delegate;

@property (weak,nonatomic) IBOutlet UIImageView *themeImageView;
@property (weak,nonatomic) IBOutlet UIButton *qianggouBtn;

@end
