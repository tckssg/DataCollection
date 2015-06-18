//
//  CKCKProgress.m
//  DataCollection
//
//  Created by ChuanKai Tong on 15/6/4.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "CKCKProgress.h"

@implementation CKCKProgress
+(void)showErrorWithStatsu:(NSString *)status onView:(UIView *)superView completion:(KVNCompletionBlock)completion{
    [KVNProgress setConfiguration: [self customKVNProgressUIConfiguration]];
    if (status) {
        [KVNProgress showErrorWithStatus:status onView:superView completion:^{
            if (completion) {
                completion();
            }
        }];
        return;
    }
    [KVNProgress showErrorWithCompletion:^{
        if (completion) {
            completion();
        }
    }];
}

+(void)showSuccessWithStatsu:(NSString *)status onView:(UIView *)superView completion:(KVNCompletionBlock)completion{
    [KVNProgress setConfiguration:[self customKVNProgressUIConfiguration]];
    if (status) {
        [KVNProgress showSuccessWithStatus:status onView:superView completion:^{
            if (completion) {
                completion();
            }
        }];
        return;
    }
    
    [KVNProgress showSuccessWithCompletion:^{
        if (completion) {
            completion();
        }
    }];
}

+(void)showNetworkLoadingWithStatus:(NSString *)status onView:(UIView *)superview{
    KVNProgressConfiguration *configuration = [[KVNProgressConfiguration alloc] init];
    //    configuration.tapBlock = ^(KVNProgress *progress){
    //
    //    }
    [KVNProgress setConfiguration:configuration];
    [KVNProgress setConfiguration:[self customKVNProgressUIConfiguration]];
    if (status) {
        [KVNProgress showWithStatus:status onView:superview];
        return;
    }
    [KVNProgress show];
}

+(void)dismissWithCompletion:(KVNCompletionBlock)completion{
    [KVNProgress dismissWithCompletion:^{
        if (completion) {
            completion();
        }
    }];
}

+(KVNProgressConfiguration *)customKVNProgressUIConfiguration
{
    KVNProgressConfiguration *configuration = [[KVNProgressConfiguration alloc] init];
    
    // See the documentation of KVNProgressConfiguration
    configuration.statusColor = [UIColor grayColor];
    configuration.statusFont = [UIFont systemFontOfSize:17.0f];
    configuration.successColor = kColor(34, 252, 19);
    configuration.errorColor = [UIColor redColor];
    configuration.circleStrokeForegroundColor = [UIColor grayColor];
    configuration.circleSize = 80.0f;
    configuration.lineWidth = 6.0f;
    configuration.minimumSuccessDisplayTime = 1.0f;
    configuration.minimumErrorDisplayTime = 1.0f;
    configuration.backgroundType = 0;
    
    return configuration;
}
@end
