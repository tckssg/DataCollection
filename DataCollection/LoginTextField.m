//
//  LoginTextField.m
//  ComeHereBusiness
//
//  Created by ChuanKai Tong on 15/4/11.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "LoginTextField.h"

@implementation LoginTextField
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(CGRectGetWidth(self.leftView.frame)+5, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(CGRectGetWidth(self.leftView.frame)+5, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}
@end
