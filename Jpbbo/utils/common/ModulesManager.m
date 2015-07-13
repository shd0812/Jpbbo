//
//  ModulesManager.m
//  JPbbo
//
//  Created by jpbbo on 15/7/3.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "ModulesManager.h"

@implementation ModulesManager

+ (ModulesManager *)defaultManager {
    static ModulesManager *manager = nil;
    @synchronized(self) {
        if (manager == nil) {
            manager = [[ModulesManager alloc] init];
        }
    }
    return manager;
}

- (UITabBarController *)tabBarController {
    if (_tabBarController) {
        return _tabBarController;
    }
    if ([self.navigationController.viewControllers count] > 0) {
        if ([[self.navigationController.viewControllers objectAtIndex:0] isKindOfClass:[UITabBarController class]]) {
            return [self.navigationController.viewControllers objectAtIndex:0];
        }
    }
    return nil;
}

- (BOOL)login {
    if (UserDefaultEntity.session_id.length) {
        return YES;
    }
    return NO;
}

/**
 *  检测当前网络连接状态
 *
 *  @return
 */
- (BOOL)isExistNetWork{
    
    BOOL isExist = NO;
    // fixme: AFNetworkReachabilityManager
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable: //无网络
            isExist = NO;
            break;
        case ReachableViaWWAN://WLAN
            isExist = YES;
            break;
        case ReachableViaWiFi://WIFI
            isExist = YES;
            break;
        default:
            break;
    }
    return isExist;
}

-(BOOL)checkNetworkConnection{
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}



@end
