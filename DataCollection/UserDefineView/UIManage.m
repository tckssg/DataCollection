//
//  UIManage.m
//  ComeHereBusiness
//
//  Created by ChuanKai Tong on 15/4/2.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "UIManage.h"

@implementation UIManage
+(UITextField *)createChoseTextFieldWithFrame :(CGRect)frame placeholder: (NSString *)placeholder action:(SEL)action  textFieldDelegate: (id) target LeftLabelText: (NSString *)labelText leftLabelFrame: (CGRect)labelFrame{
    UILabel *label = [[UILabel alloc]initWithFrame:labelFrame];
    label.text = labelText;
    
    UIImageView *arrowView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    arrowView.image = [UIImage imageNamed:@"down_arrow"];
    arrowView.contentMode = UIViewContentModeCenter;
    
    UITextField *textField = [self createTextFieldWithFrame:frame delegte:target placeholder:placeholder leftView:label];
//    textField.layer.cornerRadius = 4;
    textField.backgroundColor = RGBACOLOR(255, 255, 255, 0.3);
    textField.rightView = arrowView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.textAlignment = NSTextAlignmentRight;
    textField.delegate = target ? target : nil;
    
    if (target && action) {
        UIButton *button = [[UIButton alloc]initWithFrame: textField.bounds];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [textField addSubview:button];
    }
    
    return textField;
}

+(UITextField *)createTextFieldWithFrame :(CGRect)frame placeholder: (NSString *)placeholder textFieldDelegate: (id) target LeftLabelText: (NSString *)labelText leftLabelFrame: (CGRect)labelFrame cornerRadius: (CGFloat)cornerRadius{
    UILabel *label = [[UILabel alloc]initWithFrame:labelFrame];
    label.text = labelText;
    
    UITextField *textField = [self createTextFieldWithFrame:frame delegte:target placeholder:placeholder leftView:label];
    textField.layer.cornerRadius = cornerRadius;
    textField.backgroundColor = RGBACOLOR(255, 255, 255, 0.3);
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.textAlignment = NSTextAlignmentRight;
    textField.delegate = target ? target : nil;
    
    return textField;
}

//+(UIView *)createDoubleTextFieldViewWithFrame: (CGRect) frame leftLabel

+(UITextField *)createUITextFieldFrame:(CGRect)rect delegate:(id)target text:(NSString *)content placeholder:(NSString *)placeholder withborStyle:(UITextBorderStyle)style returnKey:(UIReturnKeyType)keyTyle keyBoard:(UIKeyboardType)keyBoard textFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment cleanButtonModel:(UITextFieldViewMode)cleanMode{
    UITextField *textField = [[UITextField alloc]initWithFrame:rect];
    if (target != nil) {
        textField.delegate = target;
    }
    if (content != nil) {
        textField.text = content;
    }
    if (placeholder !=nil) {
        textField.placeholder = placeholder;
    }
    if (font) {
        textField.font = font;
    }
    if (color) {
        textField.textColor = color;
    }
    textField.autocapitalizationType = 0;
    textField.autocorrectionType = 0;
    
    textField.clearButtonMode =  cleanMode;
    textField.textAlignment = alignment;
    textField.borderStyle = style;
    textField.returnKeyType = keyTyle;
    textField.keyboardType = keyBoard;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return textField ;
}

+(UITextField *)createTextFieldWithFrame:(CGRect)frame delegte:(id)target placeholder:(NSString *)placeholder leftView:(UIView *)leftView{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    if (target) {
        textField.delegate = target;
    }
    if (placeholder) {
        textField.placeholder = placeholder;
    }
    if (leftView) {
        textField.leftView = leftView;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
    textField.backgroundColor = RGBACOLOR(255, 255, 255, 0.3);
    textField.layer.cornerRadius = 4;
    textField.textAlignment = NSTextAlignmentRight;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    return textField;
}

+(UIButton *)createButtonFrame:(CGRect)rect withBackColor:(UIColor *)bgColor BackgroundImage:(UIImage *)image lightImageView:(UIImage *)lightImage withTarget:(id)target withAction:(SEL)action withTitle:(NSString *)title withtextfont:(UIFont *)font withTextColor:(UIColor *)color{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image == nil) {
        //        button.layer.cornerRadius = 5.0f;
    }
    if (bgColor) {
        [button setBackgroundColor:bgColor];
    }
    button.frame = rect;
    if (image != nil) {
        [button setBackgroundImage:image forState:UIControlStateNormal];
    }
    if (lightImage != nil) {
        [button setBackgroundImage:lightImage forState:UIControlStateSelected];
    }
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (color) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    return button ;

}

+(UILabel *)createUILabelFrame:(CGRect)rect
                 withBackColor:(UIColor *)bgColor
                 withTextColor:(UIColor *)textColor
                  withTextFont:(UIFont *)font
             withTextAlignment:(NSTextAlignment)alignment
               withTextContent:(NSString *)content
{
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    if (bgColor) {
        label.backgroundColor = bgColor;
    }else
    {
        label.backgroundColor = [UIColor clearColor];
    }
    if (textColor) {
        label.textColor = textColor;
    }
    if (font) {
        label.font = font;
    }
    if (alignment) {
        label.textAlignment = alignment;
    }
    if (content != nil ) {
        if ([content isKindOfClass:[NSString class]]) {
            label.text = content;
        }
    }else
    {
        label.text = @"";
    }
    return label ;
}

@end

