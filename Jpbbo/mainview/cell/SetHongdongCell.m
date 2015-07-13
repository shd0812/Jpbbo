//
//  SetHongdongCell.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/11.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "SetHongdongCell.h"

@implementation SetHongdongCell

- (void)awakeFromNib {
    // Initialization code
    
    _setImageView.layer.masksToBounds=YES;
    _setImageView.layer.cornerRadius=4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
