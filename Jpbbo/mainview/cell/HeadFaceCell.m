//
//  HeadFaceCell.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/9.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "HeadFaceCell.h"

@implementation HeadFaceCell

- (void)awakeFromNib {
    // Initialization code
    
    _faceImageView.layer.masksToBounds=YES;
    _faceImageView.layer.cornerRadius=_faceImageView.bounds.size.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)selectHeadFace:(id)sender{
    if ([_delegate respondsToSelector:@selector(selectHeader:index:)]) {
        [_delegate selectHeader:self index:[sender tag]];
    }
}

@end
