//
//  dateView.h
//  mimi
//
//  Created by 赵民生 on 14-8-1.
//  Copyright (c) 2014年 china23z. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol date_protocol_Delegate <NSObject>

-(void)date:(NSString*)dateStr;

@end


@interface dateView : UIActionSheet<UIPickerViewDelegate, UIPickerViewDataSource,date_protocol_Delegate>
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, unsafe_unretained) id<date_protocol_Delegate> date_delegate;

@property (strong, nonatomic) NSString *date;

- (IBAction)endAction:(id)sender;

@end
