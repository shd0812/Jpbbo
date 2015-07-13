//
//  ParamTableViewCell.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/7.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParamTableViewCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UIImageView *paramImageView;

@property(nonatomic, weak) IBOutlet UILabel *nameLabel;

@property(nonatomic, weak) IBOutlet UILabel *paramLabel;


-(void)updateData:(NSDictionary*)dict;

@end
