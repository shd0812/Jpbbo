//
//  AppDelegate.h
//  Jpbbo
//
//  Created by jpbbo on 15/7/1.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *rootNavigationController;

@property (nonatomic, strong) BMKMapManager *bmkManager;

@property (nonatomic, strong) BMKUserLocation *userLocation;

@property (nonatomic ,strong) CLLocationManager *locationManager;

@property (nonatomic, strong) NSString *trackViewURL;



@end

