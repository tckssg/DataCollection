//
//  CKCKProgress.h
//  DataCollection
//
//  Created by ChuanKai Tong on 15/6/4.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVNProgress.h"

@interface CKCKProgress : NSObject
/**
 *  显示网络加载界面
 *
 *  @param status    加载状态文字
 *  @param superview 显示的view
 */
+(void)showNetworkLoadingWithStatus: (NSString*) status onView:(UIView *) superview;
/**
 *  处理成功
 *
 *  @param status    处理成功状态文字
 *  @param superView view
 */
+(void)showSuccessWithStatsu: (NSString *)status onView: (UIView *)superView completion: (KVNCompletionBlock) completion;
/**
 *  处理失败
 *
 *  @param status    失败原因文字
 *  @param superView view
 */
+(void)showErrorWithStatsu: (NSString *)status onView: (UIView *)superView completion: (KVNCompletionBlock) completion;
/**
 *  隐藏网络加载界面
 */
+(void)dismissWithCompletion:(KVNCompletionBlock)completion;
@end
