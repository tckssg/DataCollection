//
//  UIViewController+Expand.h
//  单店App
//
//  Created by mac  on 13-12-3.
//  Copyright (c) 2013年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDevice+SCREEN.h"

@interface UIViewController (Expand)

/**
 *  添加左边的leftBarButtonItem(解决IOS7 10px的偏移纠正)
 *
 *  @param leftBarButtonItem
 */
- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem;



/**
 *  添加右边rightBarButtonItem(解决IOS7 10px的偏移纠正)
 *
 *  @param rightBarButtonItem
 */
- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem;



/**
 *  是否开启全屏布局(ios7)
 *
 *  @param FullScreen
 */
-(void)FullScreen:(BOOL)FullScreen;


/**
 *  是否开启ScrollView可以滚动整个屏幕(ios7)
 *
 *  @param FullScreen
 */
-(void)ScrollFullScreen:(BOOL)FullScreen;


/**
 *  是否开启毛玻璃比较明显(ios7)
 *
 *  @param Translucent
 */
-(void)Translucent:(BOOL)Translucent;


/**
 *  是否开启右滑返回(ios7)
 *
 *  @param GestureRecognizer
 */
-(void)interactivePopGestureRecognizer:(BOOL)GestureRecognizer;

@end
