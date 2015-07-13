//
//  ParentsCollectionViewCell.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/7.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentsCollectionViewCell : UICollectionViewCell

@property (weak,nonatomic) IBOutlet UIImageView *faceImageView;

@property (weak,nonatomic) IBOutlet UILabel *nameLabel;

@property (weak,nonatomic) IBOutlet UIImageView *selectedImageView;

-(void)updateController:(NSDictionary*)dict;

@end
