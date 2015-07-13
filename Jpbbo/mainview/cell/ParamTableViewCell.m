//
//  ParamTableViewCell.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/7.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "ParamTableViewCell.h"

@implementation ParamTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.paramImageView.layer.masksToBounds=YES;
    self.paramImageView.layer.cornerRadius=self.paramImageView.bounds.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateData:(NSDictionary*)dict{
    [self.paramImageView setImage:[UIImage imageNamed:[dict valueForKey:@"img"]]];
    [self.nameLabel setText:[dict valueForKey:@"name"]];
    [self.paramLabel setText:[dict valueForKey:@"param"]];
}


@end
