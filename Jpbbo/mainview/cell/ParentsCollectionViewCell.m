//
//  ParentsCollectionViewCell.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/7.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "ParentsCollectionViewCell.h"

@implementation ParentsCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _faceImageView.layer.masksToBounds=YES;
    _faceImageView.layer.cornerRadius=_faceImageView.bounds.size.height/2;
    
    _selectedImageView.layer.masksToBounds=YES;
    _selectedImageView.layer.cornerRadius=_selectedImageView.bounds.size.height/2;
}


-(void)updateController:(NSArray*)array{

}

@end
