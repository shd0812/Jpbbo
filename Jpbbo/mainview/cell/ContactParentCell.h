//
//  ContactParentCell.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/8.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface ContactParentCell : SWTableViewCell

@property (nonatomic,weak) IBOutlet UIImageView *headImageView;
@property (nonatomic,weak) IBOutlet UIImageView *watchImageView;

@property (nonatomic,weak) IBOutlet UILabel *nameLabel;

@end
