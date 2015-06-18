//
//  MenuGroup.m
//  DataCollection
//
//  Created by ChuanKai on 15/3/16.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "MenuGroup.h"

@implementation MenuGroup
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.childMenu = (NSDictionary *)dict[@"menu_child"];
        self.mainMenu = dict[@"menu_main"];
        self.identifier = [dict[@"identifer"] integerValue];
    }
    return self;
}
+(instancetype)menuGroupWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end
