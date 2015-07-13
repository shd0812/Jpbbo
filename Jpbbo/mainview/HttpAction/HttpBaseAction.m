//
//  HttpBaseAction.m
//  Jpbbo
//
//  Created by jpbbo on 15/7/2.
//  Copyright (c) 2015年 河南金马电子商务股份有限公司. All rights reserved.
//

#import "HttpBaseAction.h"


#define TIMEOUTSECONDS 30

@implementation HttpBaseAction

+ (AFHTTPRequestOperationManager *)defaultManager{
    static AFHTTPRequestOperationManager *manager;
    @synchronized(self){
        if (manager == nil) {
            manager=[[AFHTTPRequestOperationManager alloc]init];
            manager.requestSerializer.timeoutInterval=TIMEOUTSECONDS;
        }
    }
    return manager;
}

+(void)postRequest:(NSMutableDictionary *)parameters url:(NSString *)url complete:(HttpCompleteBlock)block{
    
    NSError *parseError=nil;
    
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:parameters options:kNilOptions error:&parseError];
    
    NSString *str=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [[HttpBaseAction defaultManager]POST:url parameters:str success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDictionary=responseObject;
        
        block(responseDictionary,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        block(nil,error);
    }];
}

+(void)getRequest:(NSString*)str complete:(HttpCompleteBlock)block{
    
    
    //NSString *str=[NSString stringWithFormat:@"https://alpha-api.app.net/stream/0/posts/stream/global"];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        block(dict,nil);
        NSLog(@"获取到的数据为：%@",dict);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);
        NSLog(@"发生错误！%@",error);
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

@end
