//
//  ThemeTitleTableViewCell.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/2.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "ThemeTitleTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ThemeTitleTableViewCell

- (void)awakeFromNib {
    
    NSString *url=nil;
    
    [self.themeImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"tishi.png"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(IBAction)clickBtn:(id)sender{
    if ([self.delegate respondsToSelector:@selector(clickSubject:index:)]) {
        [self.delegate clickSubject:self index:[sender tag]];
    }
}

@end
