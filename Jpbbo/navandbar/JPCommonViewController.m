//
//  JPCommonViewController.m
//  JPbbo
//
//  Created by jpbbo on 15/7/3.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "JPCommonViewController.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "helpDefine.h"

#ifndef IOS7_OR_LATER
#define IOS7_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#endif

@interface JPCommonViewController ()

@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;

@end

@implementation JPCommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#if __IPHONE_7_0
    if ( IOS7_OR_LATER ) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#endif
    self.netWorkOperation=[[NetRequestOperation alloc]initWithViewController:self];
    
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    self.returnKeyHandler.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonAction:)];

}

- (void)dealloc{
    
    self.returnKeyHandler = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backBarButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)resignFirstResponder{
    UIView *responder = [self findFirstResponderBeneathView:self.view];
    return [super resignFirstResponder]||[responder resignFirstResponder];
}

- (UIView*)findFirstResponderBeneathView:(UIView*)view {
    // Search recursively for first responder
    for ( UIView *childView in view.subviews ) {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] ) return childView;
        UIView *result = [self findFirstResponderBeneathView:childView];
        if ( result ) return result;
    }
    return nil;
}

- (void)showTotalMsg:(NSString *)msg andView:(UIView *)view{
    
    self.hud=[[MBProgressHUD alloc] initWithView:view];
    [self.hud setLabelText:msg];
    [self.hud setMode:MBProgressHUDModeText];
    
    [self.view addSubview:self.hud];
    
    [self.hud showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [self.hud removeFromSuperview];
    }];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//显示进度轮
- (void)showActivityView:(UIView *)view{
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.activityView setCenter:CGPointMake(view.frame.size.width/2, view.frame.size.height/2)];
    
    [view addSubview:self.activityView];
    
    [self.activityView startAnimating];
}
//停止进度轮
- (void)stopActivityView{
    
    [self.activityView stopAnimating];
    
    [self.activityView removeFromSuperview];
}


- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


@end
