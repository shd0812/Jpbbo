//
//  HomeHoudongCellOne.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/6.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "HomeHoudongCellOne.h"

@implementation HomeHoudongCellOne

- (void)awakeFromNib {
    // Initialization code
    
    self.oneImageView.layer.masksToBounds = YES;
    self.oneImageView.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setCellValue:(NSArray*)array{
    NSDictionary *dic = array[0];
    //NSString *url=[NSString stringWithFormat:@"%@%@",HOME_IMAGE_URL,[dic objectForKey:@"img"]];
    // NSString* str = [NSString stringWithFormat:@"%@beanName=subjectImageDown&id=%@&type=ios&time=%@",HOME_HOT_URL,[dic valueForKey:@"id"],[[dic valueForKey:@"createDate"]stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    [self.oneImageView setImage:[UIImage imageNamed:[dic valueForKey:@"img"]]];
    //[self.oneImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"no_image.9.png"]];
}

-(IBAction)dongClick:(id)sender{
    if ([_delegate respondsToSelector:@selector(dongOneCell:clickAtIndex:)]) {
        [_delegate dongOneCell:self clickAtIndex:[sender tag]];
    }
}


@end
