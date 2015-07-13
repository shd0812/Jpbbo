//
//  JPWebViewController.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/11.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "JPWebViewController.h"

@interface JPWebViewController ()

@property (nonatomic,strong)IBOutlet UIWebView *comWebView;

@end

@implementation JPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.comWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
