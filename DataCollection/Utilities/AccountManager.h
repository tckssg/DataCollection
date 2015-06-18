//
//  AccountManager.h
//  ComeHereBusiness
//
//  Created by ChuanKai Tong on 15/4/2.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AccountModel;
@interface AccountManager : NSObject
/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+ (void)saveAccount:(AccountModel *) account fileName : (NSString *)fileName;

/**
 
 *  返回存储的账号信息
 */
+ (AccountModel *)accountWithFileName: (NSString *) fileName;

/**
 *  删除登陆信息
 */
+(void)deleteAccountWithFileName : (NSString *)fileName;
@end
