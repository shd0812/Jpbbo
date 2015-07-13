//
//  JPNavigationController.m
//  JPbbo
//
//  Created by jpbbo on 15/7/3.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "JPNavigationController.h"
#import "UIColor+theme.h"

#ifndef IOS7_OR_LATER
#define IOS7_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#endif
#ifndef IOS6_OR_LATER
#define IOS6_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending)
#endif

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

@interface JPNavigationController ()

@end

@implementation JPNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController{
    
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self _init];
    }
    return self;
}

- (void) _init{
    [self setNavView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
}

- (void)dealloc {
    @try {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }@catch (NSException *exception) {
        // do nothing, only unregistering self from notifications
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void) setNavView2{
    UIColor *titleColor=[UIColor orangeColor];
    if (IOS7_OR_LATER) {
        [[UINavigationBar appearance] setBarTintColor:titleColor];
        [[UINavigationBar appearance] setTintColor:titleColor];
    } else {
        [[UINavigationBar appearance] setTintColor:titleColor];
    }
    
    [[UINavigationBar appearance] setTranslucent:NO];
    
    UIFont *font = [UIFont fontWithName:@"Arial-ItalicMT" size:18.0];
    //UIColor *foregroundColor=[UIColor whiteColor];
    UIColor *foregroundColor = [UIColor colorWithRed:051/255 green:051/255 blue:051/255 alpha:1.0f];
    UIColor *backgroundColor = [UIColor colorWithRed:1.0f green:0.6f blue:0.2f alpha:1.0f];
    //UIColor *backgroundColor = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          foregroundColor, NSForegroundColorAttributeName,
                                                          backgroundColor, NSBackgroundColorAttributeName,
                                                          font, NSFontAttributeName,
                                                          nil]];

    
    if ([self.navigationBar respondsToSelector:@selector(shadowImage)]) {
        self.navigationBar.shadowImage = [[UIImage alloc]init]; // this is what acctually removed the shadow under navigation bar
    }
}

- (void) setNavView{
     UIColor *titleColor=[UIColor themeGrayColor];
    
    //UIColor *titleColor = [UIColor colorWithRed:26/255.0 green:144/255.0 blue:240/255.0 alpha:1.0];
    {
#if __IPHONE_6_0
        if ( IOS6_OR_LATER ) {
            
            UIFont *font = [UIFont fontWithName:@"Arial-ItalicMT" size:18.0];
            //UIColor *foregroundColor=[UIColor whiteColor];
            UIColor *foregroundColor = [UIColor colorWithRed:051/255 green:051/255 blue:051/255 alpha:1.0f];
            UIColor *backgroundColor = [UIColor colorWithRed:1.0f green:0.6f blue:0.2f alpha:1.0f];
            //UIColor *backgroundColor = [UIColor whiteColor];
            
            [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                  foregroundColor, NSForegroundColorAttributeName,
                                                                  backgroundColor, NSBackgroundColorAttributeName,
                                                                  font, NSFontAttributeName,
                                                                  nil]];
        }
#endif
        
#if __IPHONE_7_0
        if ( !IOS7_OR_LATER ) {
#endif
            UIColor *backgroudColor = [UIColor colorWithRed:1.0f green:0.6f blue:0.2f alpha:1.0f];;
            [self.navigationBar setBackgroundImage:[UIImage imageWithColor:backgroudColor size:CGSizeMake(1, 44)] forBarMetrics:UIBarMetricsDefault];
            
            [[UIBarButtonItem appearanceWhenContainedIn:[self class], nil] setBackgroundImage:[UIImage new]
                                                                                     forState:UIControlStateNormal
                                                                                   barMetrics:UIBarMetricsDefault];
            [[UIBarButtonItem appearanceWhenContainedIn:[self class], nil] setBackButtonBackgroundImage:[[UIImage imageNamed:@"icon_back7"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 18, 25, 0)]
                                                                                               forState:UIControlStateNormal
                                                                                             barMetrics:UIBarMetricsDefault];
            [[UIBarButtonItem appearanceWhenContainedIn:[self class], nil] setBackButtonBackgroundImage:[[UIImage imageNamed:@"icon_back7_highlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 18, 25, 0)]
                                                                                               forState:UIControlStateHighlighted
                                                                                             barMetrics:UIBarMetricsDefault];
            
#if __IPHONE_6_0
            if ( IOS6_OR_LATER ) {
                [[UIBarButtonItem appearanceWhenContainedIn:[self class], nil] setBackButtonBackgroundImage:[[UIImage imageNamed:@"icon_back7"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 18, 0, 0)]
                                                                                                   forState:UIControlStateNormal
                                                                                                 barMetrics:UIBarMetricsDefault];
                [[UIBarButtonItem appearanceWhenContainedIn:[self class], nil] setBackButtonBackgroundImage:[[UIImage imageNamed:@"icon_back7_highlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 18, 0, 0)]
                                                                                                   forState:UIControlStateHighlighted
                                                                                                 barMetrics:UIBarMetricsDefault];
            }
#endif
            [[UIBarButtonItem appearanceWhenContainedIn:[self class], nil] setTitleTextAttributes:
             @{ UITextAttributeFont: [UIFont systemFontOfSize:17.f],
                UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero]} forState:UIControlStateNormal];
            
            [[UIBarButtonItem appearanceWhenContainedIn:[self class], nil] setBackButtonTitlePositionAdjustment:UIOffsetMake(5, 0)
                                                                                                  forBarMetrics:UIBarMetricsDefault];
            
            
#if __IPHONE_7_0
        } else {
            
            self.navigationBar.barTintColor = titleColor;
            self.navigationBar.tintColor = [UIColor orangeColor];
            
            [self.navigationBar setBackgroundImage:[UIImage imageWithColor:titleColor size:CGSizeMake(1, 64)] forBarMetrics:UIBarMetricsDefault];
            self.navigationBar.translucent = NO;
        }
#endif
    }
    if ([self.navigationBar respondsToSelector:@selector(shadowImage)]) {
        self.navigationBar.shadowImage = [[UIImage alloc]init]; // this is what acctually removed the shadow under navigation bar
    }
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)applyTheme{
    [self setNavView];
    
}


@end
