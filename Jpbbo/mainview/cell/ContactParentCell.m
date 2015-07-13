//
//  ContactParentCell.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/8.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "ContactParentCell.h"

@implementation ContactParentCell

- (void)awakeFromNib {
    // Initialization code
    
    _headImageView.layer.masksToBounds=YES;
    _headImageView.layer.cornerRadius=_headImageView.bounds.size.height/2;
    
    _watchImageView.layer.masksToBounds=YES;
    _watchImageView.layer.cornerRadius=_watchImageView.bounds.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
