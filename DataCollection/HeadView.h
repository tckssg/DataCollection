//
//  HeadView.h
//  DataCollection
//
//  Created by ChuanKai on 15/3/16.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuGroup;
@protocol HeadViewDelegate <NSObject>
@optional
-(void)headViewDidClicked;
@end
typedef void(^AddButtonDidClickedBlock)(UIButton *button, NSInteger tableId);
typedef void(^InfoButtonDidClickedBlock)(UIButton *button, NSInteger tableId);
@interface HeadView : UITableViewHeaderFooterView
@property (nonatomic, assign) NSInteger tableId;
@property (nonatomic, copy)  MenuGroup *menuGroup;
@property (nonatomic, weak) id<HeadViewDelegate> delegate;
@property (nonatomic, copy) AddButtonDidClickedBlock addButtonDidClicked;
@property (nonatomic, copy) InfoButtonDidClickedBlock infoButtonDidClicked;

+ (instancetype)headViewWithTableView:(UITableView *)tableView;
@end
