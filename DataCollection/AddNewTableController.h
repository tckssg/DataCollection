//
//  AddNewTableController.h
//  DataCollection
//
//  Created by ChuanKai Tong on 15/5/5.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "BasicViewController.h"
typedef void(^DismissButtonClicked)(UIButton *button);
typedef void(^FinishedCreateTableBlock)(id JSON);
@interface AddNewTableController : BasicViewController
@property (nonatomic, assign) NSInteger tableId;
@property (nonatomic, copy) DismissButtonClicked dismissButtonClicked;
@property (nonatomic, copy) FinishedCreateTableBlock finishedCreateTable;
@end
