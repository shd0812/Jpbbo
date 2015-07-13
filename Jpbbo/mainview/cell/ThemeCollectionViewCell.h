//
//  ThemeCollectionViewCell.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/3.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ThemeCollectionViewCell;

@protocol ThemeCollectionViewCellDelegate <NSObject>

-(void)clickSubject:(ThemeCollectionViewCell*)cell index:(NSInteger)idndex;

@end


@interface ThemeCollectionViewCell : UICollectionViewCell

@property (weak,nonatomic) IBOutlet UIImageView *themeImageView;
@property (weak,nonatomic) IBOutlet UIButton *qianggouBtn;

@property (weak,nonatomic) id<ThemeCollectionViewCellDelegate>delegate;

@end
