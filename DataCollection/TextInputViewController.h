//
//  TextInputViewController.h
//  DataCollection
//
//  Created by ChuanKai on 15/3/17.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLFormViewController.h"
#import "MenuGroup.h"
#import "DataModels.h"

@interface TextInputViewController : XLFormViewController
@property (nonatomic, strong) NSDictionary *crops;
@property (nonatomic, strong) DataModel *cropsData;
-(id)initWithCrops: (NSDictionary *)crops cropsData:(DataModel *)cropsData menuGroup:(MenuGroup*)menuGroup;
-(id)initWithAllCrops:(MenuGroup *)crops cropsData:(DataModel *)cropsData;
@end
