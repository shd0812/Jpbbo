//
//  MyLocationViewController.m
//  JPbbo
//
//  Created by jpbbo on 15/7/4.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "MyLocationViewController.h"
#import "BMKLocationService.h"
#import "BMKMapView.h"
#import "BMapKit.h"
#import "AppDelegate.h"

@interface MyLocationViewController ()
<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) BMKLocationService *locationService;

@property (strong, nonatomic) BMKGeoCodeSearch *locationSearch;

@end

@implementation MyLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的位置"];
    // Do any additional setup after loading the view.
    
    CGRect frame=[[UIScreen mainScreen] bounds];
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setZoomLevel:19];
    [self.view addSubview:self.mapView];
    
    self.locationService = [[BMKLocationService alloc] init];
    [BMKLocationService setLocationDistanceFilter:500.0f];
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
    
    self.locationSearch = [[BMKGeoCodeSearch alloc] init];
    self.locationSearch.delegate = self;
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

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    if(userLocation){
        
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        app.userLocation = userLocation;
        
        double lat = userLocation.location.coordinate.latitude;
        double lng = userLocation.location.coordinate.longitude;
        
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){lat, lng};
        BMKReverseGeoCodeOption *options = [[BMKReverseGeoCodeOption alloc] init];
        options.reverseGeoPoint = pt;
        
        [self.locationSearch reverseGeoCode:options];
        
        //update mapview
        BMKPointAnnotation *annotation=[[BMKPointAnnotation alloc] init];
        
        annotation.coordinate=userLocation.location.coordinate;
        annotation.title=@"Here";
        
        [self.mapView addAnnotation:annotation];
        [self.mapView updateLocationData:userLocation];
        
        CLLocationCoordinate2D centerPoint = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
        [self.mapView setShowMapScaleBar:YES];
        [self.mapView setCenterCoordinate:centerPoint animated:YES];
    }
    
    NSLog(@"百度Map= lat %f, lng %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}


@end
