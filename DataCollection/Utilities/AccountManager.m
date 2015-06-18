//
//  AccountManager.m
//  ComeHereBusiness
//
//  Created by ChuanKai Tong on 15/4/2.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "AccountManager.h"
#import "AccountModel.h"
@implementation AccountManager

+(void)saveAccount:(AccountModel *)account fileName:(NSString *)fileName{
    [NSKeyedArchiver archiveRootObject:account toFile:AccountFile(fileName)];
}

+(void)deleteAccountWithFileName:(NSString *)fileName{
    NSFileManager *fileManege = [NSFileManager defaultManager];
    [fileManege removeItemAtPath:AccountFile(fileName) error:nil];
}

+(AccountModel *)accountWithFileName:(NSString *)fileName{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:AccountFile(fileName)];
}
@end
