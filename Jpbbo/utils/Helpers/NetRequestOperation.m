//
//  NetRequestOperation.m
//  ZHCloudPropertyPM
//
//  Created by ewit song on 14/12/2.
//  Copyright (c) 2014年 song song. All rights reserved.
//

#import "NetRequestOperation.h"

#import "ServiceCode.h"
#define TIMEOUTSECONDS 30
@implementation NetRequestOperation

-(instancetype)initWithViewController:(UIViewController*)Controlle{
    
    self = [super init];
    if (self) {
        requestOperationManager=[[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:SERVICE_URL]];
        viewController=Controlle;
        self.isShowLoading=YES;
        self.timeOutSeconds=TIMEOUTSECONDS;
    }
    return self;
}

- (void)PostRequest:(NSMutableDictionary*)parameters
            requestSuccess:(void (^)(NSString *returnObj))requestSuccess
            requestFailure:(void (^)(NSString *errorString))requestFailure{
    
    if (self.isShowLoading) {
        [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
    }
    
    NSError *parseError = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:parameters  options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    __block UIViewController *vc=viewController;

    requestOperationManager.requestSerializer.timeoutInterval=self.timeOutSeconds;
    [requestOperationManager POST:SERVICE_URL parameters:str  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [MBProgressHUD hideAllHUDsForView:vc.view animated:YES];
            NSDictionary *responseDictionary=responseObject;

            requestSuccess(responseDictionary);

        } failure:^(AFHTTPRequestOperation *operation, NSError *error){
            
            [MBProgressHUD hideAllHUDsForView:vc.view animated:YES];
            NSLog(@"%@",error.description);
            requestFailure(@"网络连接异常！");
    }];
}

-(void)PostRequest2:(NSDictionary *)parameters requestSuccess:(void (^)(NSDictionary *))requestSuccess requestFailure:(void (^)(NSString *))requestFailure{
    
    if (self.isShowLoading) {
        [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
    }
    
    __block UIViewController *vc=viewController;
    
    NSString *url=[NSString stringWithFormat:@"%@%@",SERVICE_URL,@"advert/getList.htm"];
    
    //把传进来的URL字符串转变为URL地址
    NSURL *URL = [NSURL URLWithString:url];
    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:20];
    //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
    NSString *parseParamsResult = [self parseParams:parameters];
    NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];//请求头
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableLeaves error:nil];
    
    if (result !=nil) {
        [MBProgressHUD hideAllHUDsForView:vc.view animated:YES];
        requestSuccess(result);
    } else {
        [MBProgressHUD hideAllHUDsForView:vc.view animated:YES];
        requestFailure(@"网络连接异常！");
    }
}

//把NSDictionary解析成post格式的NSString字符串
- (NSString *)parseParams:(NSDictionary *)params{
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&",key,[params valueForKey:key]];
        [result appendString:keyValueFormat];
        //NSLog(@"post()方法参数解析结果：%@",result);
    }
    return result;
}


-(void)cancelRequest{
    [requestOperationManager.operationQueue cancelAllOperations];
}

@end
