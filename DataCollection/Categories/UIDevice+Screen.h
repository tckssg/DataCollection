//
//  UIDevice+Screen.h
//  ComeHereBusiness
//
//  Created by ChuanKai Tong on 15/4/2.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sys/sysctl.h>

typedef enum {
    IOS_System_Version_5,//iOS5.0
    IOS_System_Version_6,//iOS6.0
    IOS_System_Version_7,//iOS7.0
    IOS_System_Version_8,
}IOS_System_Version_Type;

@interface UIDevice(Screen)
//获取设备型号
+ (NSString *) platform;
//返回系统版本
+ (IOS_System_Version_Type)systemVersionType;
//系统版本不小于IOS7.0
+ (BOOL)systemVersionNoLessThenIOS7;
//系统版本小于IOS6
+(BOOL)systemVersionLessThenIOS6;
+ (BOOL)isLongScreen;

//界面内容的高度
+ (int)contentViewHeight;
//界面内容的frame
+ (CGRect)contentViewFrame;
//导航条高度
+ (int) navigationBarHeight;

//扣除导航条高度的内容高度
+ (int) navigationContentViewHeight;
//扣除导航条高度的内容frame
+ (CGRect) navigationContentViewFrame;

//扣除导航条和底部工具条工地高度的内容高度
+ (int) navigationAndTabBarContentViewHeight;
//扣除导航条高度的内容frame
+ (CGRect) navigationAndTabBarContentViewFrame;


//屏幕的高度
+ (int)screenHeight;

/**
 *  屏幕的宽度
 *
 *  @return int
 */
+(int) screenWidth;

//屏幕frame
+ (CGRect)screenFrame;
@end
