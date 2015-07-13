//
//  ThemeCollectionViewCell.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/3.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "ThemeCollectionViewCell.h"

@implementation ThemeCollectionViewCell

- (void)awakeFromNib {
    
    [_themeImageView setImage:[UIImage imageNamed:@"tishi.png"]];
}

-(IBAction)clickBtn:(id)sender{
    if ([self.delegate respondsToSelector:@selector(clickSubject:index:)]) {
        [self.delegate clickSubject:self index:[sender tag]];
    }
}

@end
