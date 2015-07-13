//
//  HoudongCollectionViewCell.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/3.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HoudongCollectionViewCell : UICollectionViewCell

@property (weak,nonatomic) IBOutlet UIImageView *dongImageView;
@property (weak,nonatomic) IBOutlet UILabel *nameLabel;
@property (weak,nonatomic) IBOutlet UILabel *singlePrice;
@property (weak,nonatomic) IBOutlet UILabel *marketPrice;

@end
