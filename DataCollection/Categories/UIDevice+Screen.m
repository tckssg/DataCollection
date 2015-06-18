//
//  UIDevice+Screen.m
//  ComeHereBusiness
//
//  Created by ChuanKai Tong on 15/4/2.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "UIDevice+Screen.h"

@implementation UIDevice(Screen)
//返回系统版本
+ (IOS_System_Version_Type)systemVersionType
{
    NSString *tSystemVersion=[[UIDevice currentDevice] systemVersion];
    if ([tSystemVersion compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending )
    {
        return IOS_System_Version_8;
    }else if ([tSystemVersion compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending )
    {
        return IOS_System_Version_7;
    }
    else if ([tSystemVersion compare:@"6.0" options:NSNumericSearch] != NSOrderedAscending )
    {
        return IOS_System_Version_6;
    }
    return IOS_System_Version_5;
}
//系统版本不小于IOS7.0
+(BOOL)systemVersionNoLessThenIOS7
{
    if (IOS_System_Version_7==[UIDevice systemVersionType] || IOS_System_Version_8==[UIDevice systemVersionType]) {
        return YES;
    }
    return NO;
}
//系统版本小于IOS6
+(BOOL)systemVersionLessThenIOS6
{
    if (IOS_System_Version_5==[UIDevice systemVersionType]) {
        return YES;
    }
    return NO;
}
//判断长屏幕
+(BOOL)isLongScreen
{
    return ([[UIScreen mainScreen] bounds].size.height >= 568);
}

//界面内容的高度
+ (int) contentViewHeight
{
    if ([UIDevice systemVersionNoLessThenIOS7]) {
        return [[UIScreen mainScreen] bounds].size.height;
    }
    return ([[UIScreen mainScreen] bounds].size.height -20) ;
}
//界面内容的frame
+ (CGRect) contentViewFrame
{
    if ([UIDevice systemVersionNoLessThenIOS7]) {
        return CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }
    //    else if ([UIDevice systemVersionType] == IOS_System_Version_6)
    //    {
    return CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 20);
    //    }else
    //    {
    //        return CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 20);
    //    }
    
}
//导航条高度
+ (int) navigationBarHeight
{
    if ([UIDevice systemVersionNoLessThenIOS7]) {
        return 64.0;
    }
    return 44.0;
}
//扣除导航条高度的内容高度
+ (int) navigationContentViewHeight
{
    return [[UIScreen mainScreen] bounds].size.height-64;
}
//扣除导航条高度的内容frame
+ (CGRect) navigationContentViewFrame
{
    return CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 64);
}
//扣除导航条和底部工具条工地高度的内容高度
+ (int) navigationAndTabBarContentViewHeight
{
    return [[UIScreen mainScreen] bounds].size.height-113;
}
//扣除导航条高度的内容frame
+ (CGRect) navigationAndTabBarContentViewFrame
{
    return CGRectMake(0, 0, ScreenWidth, [[UIScreen mainScreen] bounds].size.height - 113);
}
//获取屏幕高度
+ (int) screenHeight
{
    return [[UIScreen mainScreen] bounds].size.height;
}

#pragma mark 获取屏幕宽度
+(int) screenWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

//屏幕frame
+ (CGRect) screenFrame
{
    return [[UIScreen mainScreen] bounds];
}

//获取设备型号
+ (NSString *) platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

@end
