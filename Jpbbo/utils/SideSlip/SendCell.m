//
//  SendCell.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/8.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "SendCell.h"

@implementation SendCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)switchBtn:(id)sender{
    
    if ([_delegate respondsToSelector:@selector(clickCell:clickAtIndex:)]) {
        [_delegate clickCell:self clickAtIndex:[sender tag]];
    }
    
}

@end
