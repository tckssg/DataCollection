//
//  CKCheckBox.h
//  XianBIngJie
//
//  Created by ChuanKai on 15/1/23.
//  Copyright (c) 2015年 lsk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKCheckBox;
@protocol CKCheckBoxDelegate <NSObject>
@optional
- (void)didSelectedCheckBox:(CKCheckBox *)checkbox checked:(BOOL)checked;
@end
@interface CKCheckBox : UIButton
@property(nonatomic, assign)BOOL checked;
@property(nonatomic, assign) id<CKCheckBoxDelegate> delegate;
- (instancetype)initWithDelegate:(id)delegate;
@end
