//
//  NSString+Expend.m
//  ComeHereBusiness
//
//  Created by ChuanKai Tong on 15/4/16.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "NSString+Expend.h"

@implementation NSString(Expend)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(BOOL)validateMobilePhoneNumber{
    //手机号以13， 15，18开头，八个 \d 数字字符
    
    NSString *mobile = self;
    NSRange range = [mobile rangeOfString:@"-"];
    if (range.location != NSNotFound) {
        mobile = [mobile stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    NSString *phoneRegex = @"(^((13[0-9])|(14[7,\\D])|(17[0,\\D])||(15[0-9])|(18[0-9]))\\d{8}$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

-(BOOL)validateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

-(BOOL)validateIdentityCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}
@end
