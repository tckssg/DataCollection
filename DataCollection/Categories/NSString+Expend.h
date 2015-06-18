//
//  NSString+Expend.h
//  ComeHereBusiness
//
//  Created by ChuanKai Tong on 15/4/16.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString(Expend)
/**
 *  计算文字size
 *
 *  @param text    need caculate string
 *  @param font    font size
 *  @param maxSize rect size
 *
 *  @return <#return value description#>
 */
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
/**
 *  判断是否为手机号码
 *
 *  @return 是，YES 否NO
 */
-(BOOL)validateMobilePhoneNumber;
/**
 *  判断是否是邮箱
 *
 *  @param email
 *
 *  @return
 */
- (BOOL) validateEmail;
/**
 *  判断身份证
 *
 *  @param identityCard
 *
 *  @return
 */
- (BOOL) validateIdentityCard;
@end
