//
//  TableInfoView.m
//  DataCollection
//
//  Created by ChuanKai Tong on 15/6/4.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "TableInfoView.h"
#import "DataModel.h"

#define ViewMargin 10

@interface TableInfoView()
@property (nonatomic, strong) UITextField *tableNum;
@property (nonatomic, strong) UITextField *makeName;
@property (nonatomic, strong) UITextField *fileNumber;
@property (nonatomic, strong) UITextField *deadline;
@property (nonatomic, strong) UITextField *unit;
@end

@implementation TableInfoView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableNum];
        [self addSubview:self.makeName];
        [self addSubview:self.fileNumber];
        [self addSubview:self.deadline];
        [self addSubview:self.unit];
    }
    return self;
}

#pragma getter and setter
-(UITextField *)tableNum{
    if (!_tableNum) {
        _tableNum = [UIManage createTextFieldWithFrame:CGRectMake(ViewMargin, ViewMargin, 300, 30) placeholder:nil textFieldDelegate:nil LeftLabelText:@"表号: " leftLabelFrame:CGRectMake(0, 0, 100, 20) cornerRadius:0.0f];
        _tableNum.textColor = kColor(26, 111, 234);
        _tableNum.backgroundColor = [UIColor clearColor];
        _tableNum.clearButtonMode = UITextFieldViewModeNever;
        _tableNum.enabled = NO;
    }
    return _tableNum;
}

-(UITextField *)makeName{
    if (!_makeName) {
        _makeName = [UIManage createTextFieldWithFrame:CGRectMake(ViewMargin, CGRectGetMaxY(self.tableNum.frame) + ViewMargin, 300, 30) placeholder:nil textFieldDelegate:nil LeftLabelText:@"制定机关: " leftLabelFrame:CGRectMake(0, 0, 100, 20) cornerRadius:0.0f];
        _makeName.textColor = kColor(26, 111, 234);
        _makeName.backgroundColor = [UIColor clearColor];
        _makeName.clearButtonMode = UITextFieldViewModeNever;
        _makeName.enabled = NO;
    }
    return _makeName;
}

-(UITextField *)fileNumber{
    if (!_fileNumber) {
        _fileNumber = [UIManage createTextFieldWithFrame:CGRectMake(ViewMargin, CGRectGetMaxY(self.makeName.frame) + ViewMargin, 300, 30) placeholder:nil textFieldDelegate:nil LeftLabelText:@"文号: " leftLabelFrame:CGRectMake(0, 0, 100, 20) cornerRadius:0.0f];
        _fileNumber.textColor = kColor(26, 111, 234);
        _fileNumber.backgroundColor = [UIColor clearColor];
        _fileNumber.clearButtonMode = UITextFieldViewModeNever;
        _fileNumber.enabled = NO;
    }
    return _fileNumber;
}

-(UITextField *)deadline{
    if (!_deadline) {
        _deadline = [UIManage createTextFieldWithFrame:CGRectMake(ViewMargin, CGRectGetMaxY(self.fileNumber.frame) + ViewMargin, 300, 30) placeholder:nil textFieldDelegate:nil LeftLabelText:@"有效期: " leftLabelFrame:CGRectMake(0, 0, 100, 20) cornerRadius:0.0f];
        _deadline.textColor = kColor(26, 111, 234);
        _deadline.backgroundColor = [UIColor clearColor];
        _deadline.clearButtonMode = UITextFieldViewModeNever;
        _deadline.enabled = NO;
    }
    return _deadline;
}

-(UITextField *)unit{
    if (!_unit) {
        _unit = [UIManage createTextFieldWithFrame:CGRectMake(ViewMargin, CGRectGetMaxY(self.deadline.frame) + ViewMargin, 300, 30) placeholder:nil textFieldDelegate:nil LeftLabelText:@"计量单位: " leftLabelFrame:CGRectMake(0, 0, 100, 20) cornerRadius:0.0f];
        _unit.textColor = kColor(26, 111, 234);
        _unit.backgroundColor = [UIColor clearColor];
        _unit.clearButtonMode = UITextFieldViewModeNever;
        _unit.enabled = NO;
    }
    return _unit;
}

-(void)setDataModel:(DataModel *)dataModel{
    self.tableNum.text = dataModel.tableIndeifer;
    self.makeName.text = dataModel.makeName;
    self.fileNumber.text = dataModel.fileNumber;
    self.deadline.text = dataModel.deadline;
    self.unit.text = dataModel.unit;
}

@end
