//
//  UIManage.h
//  ComeHereBusiness
//
//  Created by ChuanKai Tong on 15/4/2.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIManage : NSObject

/**
 *  创建UITextField
 *
 *  @param rect        rect
 *  @param target      target
 *  @param content     content
 *  @param placeholder placeholder
 *  @param style       style
 *  @param keyTyle     keyTyle
 *  @param keyBoard    keyBoard
 *  @param font        font
 *  @param color       color
 *  @param alignment   alignment
 *  @param cleanMode   cleanMode
 *
 *  @return UITextField
 */

+(UITextField *)createChoseTextFieldWithFrame :(CGRect)frame placeholder: (NSString *)placeholder action:(SEL)action  textFieldDelegate: (id) target LeftLabelText: (NSString *)labelText leftLabelFrame: (CGRect)labelFrame;

+(UITextField *)createTextFieldWithFrame :(CGRect)frame placeholder: (NSString *)placeholder textFieldDelegate: (id) target LeftLabelText: (NSString *)labelText leftLabelFrame: (CGRect)labelFrame cornerRadius: (CGFloat)cornerRadius;

+(UITextField *)createUITextFieldFrame:(CGRect)rect
                              delegate:(id)target
                                  text:(NSString *)content
                           placeholder:(NSString *)placeholder
                          withborStyle:(UITextBorderStyle)style
                             returnKey:(UIReturnKeyType)keyTyle
                              keyBoard:(UIKeyboardType)keyBoard
                              textFont:(UIFont *)font
                             textColor:(UIColor *)color
                         textAlignment:(NSTextAlignment)alignment
                      cleanButtonModel:(UITextFieldViewMode)cleanMode;

+(UITextField *)createTextFieldWithFrame: (CGRect)frame delegte:(id)target placeholder:(NSString *)placeholder leftView: (UIView *)leftView;

+(UIButton *)createButtonFrame:(CGRect)rect withBackColor:(UIColor *)bgColor BackgroundImage:(UIImage *)image lightImageView:(UIImage *)lightImage withTarget:(id)target withAction:(SEL)action withTitle:(NSString *)title withtextfont:(UIFont *)font withTextColor:(UIColor *)color;
+(UILabel *)createUILabelFrame:(CGRect)rect
                 withBackColor:(UIColor *)bgColor
                 withTextColor:(UIColor *)textColor
                  withTextFont:(UIFont *)font
             withTextAlignment:(NSTextAlignment)alignment
               withTextContent:(NSString *)content;
@end
