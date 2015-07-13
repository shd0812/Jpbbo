//
//  AppDelegate.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/1.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "AppDelegate.h"

#import "Utils.h"
#import "UIViewController+Xib.h"
#import "HttpBaseAction.h"

#import "ModulesManager.h"

#import "IQKeyboardManager.h"


#define BAIDUMAP @"4fEVX1dyLmbRKcUTYMGXSdj9"

#define APP_VERSION @"https://itunes.apple.com/lookup?id=996408128"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //初始化百度地图
    self.bmkManager = [[BMKMapManager alloc] init];
    [self.bmkManager start:BAIDUMAP generalDelegate:(id<BMKGeneralDelegate>)self];
    
    if([[UIDevice currentDevice].systemVersion floatValue] > 8){
        
        self.locationManager =[ [CLLocationManager alloc] init];
        
        [self.locationManager requestAlwaysAuthorization];
        
        [self.locationManager requestWhenInUseAuthorization];
        
    }
    
    //启动键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    //启用/禁用键盘
    manager.enable = YES;
    //启用/禁用键盘触摸外面
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    /**
    if (![[ModulesManager defaultManager]isExistNetWork]) {
        [self presentTutorialViewController];
        
        [Utils showAlertView:@"注意" :@"您当前的网络不可用" :@"知道了"];
    }else{
        if([self.window.rootViewController isKindOfClass:[UINavigationController class]]){
            [[ModulesManager defaultManager] setNavigationController:(UINavigationController *)self.window.rootViewController];
        }
    }**/
    
    if([self.window.rootViewController isKindOfClass:[UINavigationController class]]){
        [[ModulesManager defaultManager] setNavigationController:(UINavigationController *)self.window.rootViewController];
    }
    
    //[self checkVersion:APP_VERSION];
    
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:500.f];

    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Navigation control

// 欢迎页
- (void)presentTutorialViewController {
    //进入欢迎页
}

- (void)replaceRootControllerBy:(UIViewController *)vc {
    UINavigationController *rootNavigationController = self.rootNavigationController;
    [rootNavigationController setViewControllers:[NSArray arrayWithObject:vc] animated:YES];
}


- (void)checkVersion:(NSString *)appurl{
    
    [HttpBaseAction getRequest:appurl complete:^(id result, NSError *error) {
        if (error == nil && result) {
            NSArray *infoArray = [result objectForKey:@"results"];
            if (infoArray.count>0) {
                NSDictionary *releaseInfo =[infoArray objectAtIndex:0];
                NSString *appStoreVersion = [releaseInfo objectForKey:@"version"];
                NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
                NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
                if (![appStoreVersion isEqualToString:currentVersion]){
                    
                    _trackViewURL = [[NSString alloc] initWithString:[releaseInfo objectForKey:@"trackViewUrl"]];
                    NSString* msg =[releaseInfo objectForKey:@"releaseNotes"];
                    [Utils showAlertView:@"版本升级" :[NSString stringWithFormat:@"%@%@%@", @"新版本特性:",msg, @"\n是否升级？"] :@"稍后升级" :@"马上升级"];
                }
            }
        }else{
            NSLog(@"%@",@"获取参数失败！");
        }

    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==1) {
        UIApplication *application = [UIApplication sharedApplication];
        [application openURL:[NSURL URLWithString:_trackViewURL]];
    }
}

/**
- (void)onGetNetworkState:(int)iError{
    if (0 == iError) {
        NSLog(@"联网成功");
    }else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError{
    if (0 == iError) {
        NSLog(@"授权成功");
    }else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
}**/

@end
