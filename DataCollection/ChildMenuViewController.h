//
//  ChildMenuViewController.h
//  DataCollection
//
//  Created by ChuanKai on 15/3/17.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModels.h"

@class MenuGroup;
typedef void(^tableViewCellDidClicked)(NSDictionary *crpos, NSIndexPath *indexPath, DataModel *cropsData);
@interface ChildMenuViewController : UIViewController
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSDictionary *childMenu;
@property(nonatomic, strong) DataModel *cropsDetailData;
@property (nonatomic, strong) NSArray *tableArray;
@property (nonatomic, strong) MenuGroup *menuGroup;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) tableViewCellDidClicked tableViewCellDidClicked;
@end
