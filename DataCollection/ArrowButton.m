//
//  ArrowButton.m
//  ComeHereBusiness
//
//  Created by ChuanKai Tong on 15/5/1.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "ArrowButton.h"
#define arrowW 15

@implementation ArrowButton
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self inilization];
    }
    return self;
}

-(void)inilization{
    [self setImage:[UIImage imageNamed: @"down_arrow"] forState:UIControlStateNormal];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat width = CGRectGetWidth(contentRect);
    CGFloat height = CGRectGetHeight(contentRect);
    return CGRectMake(width - arrowW, (height - arrowW)/2, arrowW, arrowW);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat width = CGRectGetWidth(contentRect);
    CGFloat height = CGRectGetHeight(contentRect);
    return CGRectMake(0, 0, width - arrowW, height);
}

@end
