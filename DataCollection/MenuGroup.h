//
//  MenuGroup.h
//  DataCollection
//
//  Created by ChuanKai on 15/3/16.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuGroup : NSObject
@property(nonatomic, copy)NSString *mainMenu;
@property(nonatomic, assign) NSInteger identifier;
@property(nonatomic, strong) NSDictionary *childMenu;
@property (nonatomic, assign, getter = isOpened) BOOL opened;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)menuGroupWithDict:(NSDictionary *)dict;
@end
