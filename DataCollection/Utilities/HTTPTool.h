//
//  HTTPTool.h
//  SinaWeibo
//
//  Created by ChuanKai Tong on 15/3/28.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^HttpSuccessBlock)(id JSON);
typedef void (^HttpFailureBlock)(NSError *error);

@interface HTTPTool : NSObject<NSXMLParserDelegate>
+(void)postWithSourceString:(NSString *)sourceString params: (NSDictionary *)params success:(HttpSuccessBlock)success failure: (HttpFailureBlock)failure;
+(void)getWithSourceString:(NSString *)sourceString success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;
@end
