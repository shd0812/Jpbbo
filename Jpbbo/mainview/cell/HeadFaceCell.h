//
//  HeadFaceCell.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/9.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeadFaceCell;

@protocol HeadFaceCellDelegate <NSObject>

-(void)selectHeader:(HeadFaceCell*)cell index:(NSInteger)idndex;

@end

@interface HeadFaceCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIImageView *faceImageView;

@property (nonatomic,strong) id<HeadFaceCellDelegate>delegate;

@end
