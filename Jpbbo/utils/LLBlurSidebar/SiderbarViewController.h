//
//  SiderbarViewController.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/8.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "LLBlurSidebar.h"

typedef void (^didSelectRowAtIndexPath)(id cell, NSIndexPath *indexPath);

@interface SiderbarViewController : LLBlurSidebar{
    didSelectRowAtIndexPath _didSelectRowAtIndexPath;
}

@property (strong, nonatomic) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic ,strong) NSString *type;

-(void)didSelectRowAtIndexPath:(void (^)(id cell, NSIndexPath *indexPath))didSelectRowAtIndexPath;

@end
