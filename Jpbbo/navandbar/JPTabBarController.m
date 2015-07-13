//
//  JPTabBarController.m
//  JPbbo
//
//  Created by jpbbo on 15/7/3.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "JPTabBarController.h"
#import "ModulesManager.h"
#import "UIColor+theme.h"
#import "MyInfoViewController.h"
#import "MyParentsViewController.h"
#import "JPLoginViewController.h"

#ifndef IOS7_OR_LATER
#define IOS7_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#endif

@interface JPTabBarController ()

@end

@interface UIImage (JPNavigationController)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end

@implementation UIImage (JPNavigationController)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

@implementation JPTabBarController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonAction:)];
    self.delegate = (id<UITabBarControllerDelegate>)self;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor lightGrayColor], NSForegroundColorAttributeName,
                                                       [UIFont systemFontOfSize:12.0], NSFontAttributeName,
                                                       nil]
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor rightOrangeColor], NSForegroundColorAttributeName,
                                                       [UIFont systemFontOfSize:12.0], NSFontAttributeName,
                                                       nil]
                                             forState:UIControlStateSelected];
    
    //[self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 49)]];
    if ( IOS7_OR_LATER ) {
        self.tabBar.translucent = NO;
    }
}

- (void)backBarButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        
        if (([[((UINavigationController *)viewController).viewControllers objectAtIndex:0] isKindOfClass:[MyParentsViewController class]] || [[((UINavigationController *)viewController).viewControllers objectAtIndex:0] isKindOfClass:[MyInfoViewController class]] )&& [ModulesManager defaultManager].login == NO ) {
            
            JPLoginViewController *loginVC=[self.storyboard instantiateViewControllerWithIdentifier:@"JPLoginViewController"];
            [[ModulesManager defaultManager].navigationController pushViewController:loginVC animated:YES];
            
            return NO;
        }
    }
    return YES;
}

@end
