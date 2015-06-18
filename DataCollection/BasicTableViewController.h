//
//  BasicTableViewController.h
//  ComeHereBusiness
//
//  Created by ChuanKai Tong on 15/4/14.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KVNProgress.h"

@interface BasicTableViewController : UITableViewController
-(UILabel *)createLabelWithFrame: (CGRect)frame text: (NSString *)text font:(UIFont *)font;
/**
 *  计算文字size
 *
 *  @param text    need caculate string
 *  @param font    font size
 *  @param maxSize rect size
 *
 *  @return <#return value description#>
 */
-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  显示网络加载界面
 *
 *  @param status    加载状态文字
 *  @param superview 显示的view
 */
-(void)showNetworkLoadingWithStatus: (NSString*) status onView:(UIView *) superview;
/**
 *  处理成功
 *
 *  @param status    处理成功状态文字
 *  @param superView view
 */
-(void)showSuccessWithStatsu: (NSString *)status onView: (UIView *)superView completion: (KVNCompletionBlock) completion;
/**
 *  处理失败
 *
 *  @param status    失败原因文字
 *  @param superView view
 */
-(void)showErrorWithStatsu: (NSString *)status onView: (UIView *)superView completion: (KVNCompletionBlock) completion;
/**
 *  隐藏网络加载界面
 */
-(void)dismissWithCompletion:(KVNCompletionBlock)completion;
@end
