//
//  HTTPTool.m
//  SinaWeibo
//
//  Created by ChuanKai Tong on 15/3/28.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "HTTPTool.h"

@interface HTTPTool()

@end

@implementation HTTPTool

static NSString * const FORM_FLE_INPUT = @"file.jpg";

+(void)postWithSourceString:(NSString *)sourceString params:(NSMutableDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    
    NSMutableString *stringM = [NSMutableString string];
    for (id key in params.allKeys) {
        NSString *value = [params valueForKey:key];
        NSString *param = [NSString stringWithFormat:@"%@=%@&", key, value];
        [stringM appendString:param];
    }
    NSString *bodyString = [stringM substringToIndex:stringM.length - 1];
   
    NSString *urlString = [SERVER_HOST_URL stringByAppendingString:sourceString];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *requestM = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:0 timeoutInterval:5.0f];
    [requestM setHTTPMethod:@"POST"];
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [requestM setHTTPBody:bodyData];
    
    [NSURLConnection sendAsynchronousRequest:requestM queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            success([self loadData:data]);
            return;
        }else{
            failure(connectionError);
        }
    }];
}

+(void)getWithSourceString:(NSString *)sourceString success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    NSString *urlString = [SERVER_HOST_URL stringByAppendingString:sourceString];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *requestM = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:0 timeoutInterval:5.0f];
    [requestM setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:requestM queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            success([self loadData:data]);
            return;
        }else{
            failure(connectionError);
        }
    }];
}

+(id)loadData: (NSData *)data{
    id serializedData = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    return serializedData;
}

@end
