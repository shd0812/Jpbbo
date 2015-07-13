//
//  HuodongCellTwo.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/2.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "HuodongCellTwo.h"
#import "UIImageView+WebCache.h"

@implementation HuodongCellTwo

- (void)awakeFromNib {
    // Initialization code
    
    self.dongImageView1.layer.masksToBounds = YES;
    self.dongImageView1.layer.cornerRadius = 3;
    
    self.dongImageView2.layer.masksToBounds = YES;
    self.dongImageView2.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateData:(NSMutableArray*)array{
    
    if([array count]>0){
        NSDictionary *model=[array objectAtIndex:0];
        
        //NSString *path=[NSString stringWithFormat:@"%@",@"http://"];
        //[_dongImageView1 sd_setImageWithURL:[NSURL URLWithString:[path stringByAppendingString:[model valueForKey:@"img"]]] placeholderImage:[UIImage imageNamed:@"no_image.9.png"]];
        [_dongImageView1 setImage:[UIImage imageNamed:[model valueForKey:@"img"]]];
        
        _nameLabel1.text=[model valueForKey:@"name"];
        _dongPrice1.text=[NSString stringWithFormat:@"%@%@",@"¥",[model valueForKey:@"dongPrice"]];
        
        _truePrice1.text=[NSString stringWithFormat:@"%@%@",@"¥",[model valueForKey:@"truePrice"]];
        
    }else{
        [_dongImageView1 sd_setImageWithURL:nil placeholderImage:nil];
        _nameLabel1.text=nil;
        _dongPrice1.text=nil;
        _truePrice1.text=nil;
    }
    
    if([array count]>1){
        NSDictionary *model=[array objectAtIndex:1];
        
        //NSString *path=[NSString stringWithFormat:@"%@",@"http://"];
        //[_dongImageView2 sd_setImageWithURL:[NSURL URLWithString:[path stringByAppendingString:[model valueForKey:@"img"]]] placeholderImage:[UIImage imageNamed:@"no_image.9.png"]];
        [_dongImageView2 setImage:[UIImage imageNamed:[model valueForKey:@"img"]]];
        _nameLabel2.text=[model valueForKey:@"name"];
        _dongPrice2.text=[NSString stringWithFormat:@"%@%@",@"¥",[model valueForKey:@"dongPrice"]];
        
        _truePrice2.text=[NSString stringWithFormat:@"%@%@",@"¥",[model valueForKey:@"truePrice"]];

        
    }else{
        [_dongImageView2 sd_setImageWithURL:nil placeholderImage:nil];
        _nameLabel2.text=nil;
        _dongPrice2.text=nil;
        _truePrice2.text=nil;
    }
}

-(IBAction)dongClick:(id)sender{
    if ([_delegate respondsToSelector:@selector(dongCell:clickAtIndex:)]) {
        [_delegate dongCell:self clickAtIndex:[sender tag]];
    }
}

@end
