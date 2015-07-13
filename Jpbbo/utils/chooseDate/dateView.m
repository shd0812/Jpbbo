//
//  dateView.m
//  mimi
//
//  Created by 赵民生 on 14-8-1.
//  Copyright (c) 2014年 china23z. All rights reserved.
//

#import "dateView.h"
#define kDuration 0.3

@implementation dateView


- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



- (IBAction)endAction:(id)sender {
   
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"deteView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];

    // 获取用户通过UIDatePicker设置的日期和时间
	NSDate *selected = [self.datePicker date];
	// 创建一个日期格式器
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	// 为日期格式器设置格式字符串
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	// 使用日期格式器格式化日期、时间
	NSString *destDateString = [dateFormatter stringFromDate:selected];
    

    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
    
    self.date=destDateString;
    
    [self.date_delegate date:destDateString];
    
    
}


@end
