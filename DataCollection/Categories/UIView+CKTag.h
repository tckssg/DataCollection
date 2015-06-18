//
//  UIView+CKTag.h
//  ComeHereBusiness
//
//  Created by ChuanKai Tong on 15/4/20.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIView (CKTag)
@property (nonatomic, strong)NSString *tagString;

-(UIView *)viewWithTagString:(NSString *)value;
@end
