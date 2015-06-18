//
//  UIView+CKTag.m
//  ComeHereBusiness
//
//  Created by ChuanKai Tong on 15/4/20.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "UIView+CKTag.h"

#define KEY_LATESTRING "lageTag"

@implementation UIView(CKTag)

-(void)setTagString:(NSString *)tagString{
    objc_setAssociatedObject(self, KEY_LATESTRING, tagString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)tagString{
    NSString *obj = objc_getAssociatedObject(self, KEY_LATESTRING);
    if (obj  && [obj isKindOfClass:[NSString class]]) {
        return (NSString *)obj;
    }
    return nil;
}


-(UIView *)viewWithTagString:(NSString *)value{
    if (value == nil) {
        return nil;
    }
    
    for (UIView *subview in self.subviews) {
        NSString *tag = subview.tagString;
        if ([tag isEqualToString:value]) {
            return subview;
        }
    }
    
    return nil;
}
@end
