//
//  UIBarButtonItem+CustomButton.m
//
//  Created by fyp on 13-9-3.
//  Copyright (c) 2013年 fyp. All rights reserved.
//

#import "UIBarButtonItem+CustomButton.h"

@implementation UIBarButtonItem (CustomButton)


+ (UIBarButtonItem *)customBarButtonItemWithTitle:(NSString *)title
                                           target:(id)target
                                           action:(SEL)action
{
    return [UIBarButtonItem customBarButtonItemWithImageName:nil
                                         backgroundImageName:nil
                                                       title:title
                                                      target:target
                                                      action:action];
}


+ (UIBarButtonItem *)customBarButtonItemWithImageName:(NSString *)imageName
                                               target:(id)target
                                               action:(SEL)action
{
    return [UIBarButtonItem customBarButtonItemWithImageName:imageName
                                         backgroundImageName:nil
                                                       title:nil
                                                      target:target
                                                      action:action];
}

//
+ (UIBarButtonItem *)customBarButtonItemWithTitle:(NSString *)title
                              backgroundImageName:(NSString *)backgroundImageName
                                           target:(id)target
                                           action:(SEL)action
{
    return [UIBarButtonItem customBarButtonItemWithImageName:nil
                                         backgroundImageName:backgroundImageName
                                                       title:title
                                                      target:target
                                                      action:action];
}
//
+ (UIBarButtonItem *)customBarButtonItemWithImageName:(NSString *)imageName
                                  backgroundImageName:(NSString *)backgroundImageName
                                               target:(id)target
                                               action:(SEL)action
{
    return [UIBarButtonItem customBarButtonItemWithImageName:imageName
                                         backgroundImageName:backgroundImageName
                                                       title:nil
                                                      target:target
                                                      action:action];
}


+ (UIBarButtonItem *)customBarButtonItemWithImageName:(NSString *)imageName
                                  backgroundImageName:(NSString *)backgroundImageName
                                                title:(NSString *)title
                                               target:(id)target
                                               action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
//    if (backgroundImageName) {//设置背景图片
//        UIImage *buttonImage = [[UIImage imageNamed:backgroundImageName]
//                                stretchableImageWithLeftCapWidth:5 topCapHeight:10];
//        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    }
    
    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:16.0]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    CGRect buttonFrame = [button frame];
    if (title) {//有标题
        buttonFrame.size.width = [self sizeWithText:title font:[UIFont boldSystemFontOfSize:16.0f] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + 24.0;
        buttonFrame.size.height = 30.0;
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.textColor = [UIColor whiteColor];
    }
    else {
        buttonFrame=CGRectMake(0.0, 0.0, 40.0, 35.0);
        //button.imageEdgeInsets = UIEdgeInsetsMake(0.0,-10,0.0,10.0);
    }
    [button setFrame:buttonFrame];
    
    if (imageName) {//图片
        UIImage *buttonImage = [[UIImage imageNamed:imageName]
                                stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [button setImage:buttonImage forState:UIControlStateNormal];
    }
    if (target) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (backgroundImageName) {
        UIImage *buttonImage = [[UIImage imageNamed:backgroundImageName]
                                stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [button setImage:buttonImage forState:UIControlStateHighlighted];
    }
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return buttonItem ;
}

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
