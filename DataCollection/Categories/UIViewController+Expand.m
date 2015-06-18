//
//  UIViewController+Expand.m
//  单店App
//
//  Created by mac  on 13-12-3.
//  Copyright (c) 2013年 Sky. All rights reserved.
//

#import "UIViewController+Expand.h"


@implementation UIViewController (Expand)




#pragma ios7 自定义Leftbarbuttonitem 10px的偏移纠正
- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
{
    if ( [UIDevice systemVersionNoLessThenIOS7] )
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems=@[negativeSpacer,leftBarButtonItem];
        
    }
    else
    {
        self.navigationItem.leftBarButtonItem=leftBarButtonItem;
    }
}

#pragma ios7 自定义Rightbarbuttonitem 10px的偏移纠正
- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
{
    if ([UIDevice systemVersionNoLessThenIOS7])
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.rightBarButtonItems=@[negativeSpacer,rightBarButtonItem];
       
        
    } else
    {
        self.navigationItem.rightBarButtonItem=rightBarButtonItem;
    }
}

#pragma 是否开启全屏布局(iOS7特有属性)
-(void)FullScreen:(BOOL)FullScreen
{
    if ( [UIDevice systemVersionNoLessThenIOS7] )
    {
        if (!FullScreen)
        {
            self.edgesForExtendedLayout=UIRectEdgeNone;
        }
    }
}

#pragma 是否开启滚动UIScrollView或其子类滚动至全屏(ios7特有属性)
-(void)ScrollFullScreen:(BOOL)FullScreen
{
    if ( [UIDevice systemVersionNoLessThenIOS7] )
    {
        if (FullScreen)
        {
            self.automaticallyAdjustsScrollViewInsets=YES;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets=NO;
        }
    }
}
#pragma 是否开启强烈的毛玻璃
-(void)Translucent:(BOOL)Translucent
{
    self.navigationController.navigationBar.translucent=Translucent;
}
#pragma 是否开启右滑返回
-(void)interactivePopGestureRecognizer:(BOOL)GestureRecognizer
{
    if ( [UIDevice systemVersionNoLessThenIOS7] )
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = GestureRecognizer;
    }
}

@end
