//
//  AddNewTableController.m
//  DataCollection
//
//  Created by ChuanKai Tong on 15/5/5.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "AddNewTableController.h"
#import "ArrowButton.h"
#import "CKPopover.h"
#import "UIView+CKTag.h"

#define viewMargin 10;
#define textFieldH 60;
#define BackgroundW ScreenWidth/2;
#define BackgroundH ScreenHeight/2;

@interface AddNewTableController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UITextField *name;
@property (nonatomic, strong) UITextField *zoneField;
@property (nonatomic, strong) UITextField *addressField;
@property (nonatomic, strong) UITextField *logitudeField;
@property (nonatomic, strong) UITextField *latitudeField;
@property (nonatomic, strong) UITextField *principalNameField;

@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) NSDictionary *popoveTableData;

@property (nonatomic, strong) UITableView *popoverTable;
@property (nonatomic, strong) ArrowButton *proviceButton;
@property (nonatomic, strong) ArrowButton *cityButton;
@property (nonatomic, strong) ArrowButton *countyButton;
@property (nonatomic, strong) CKPopover *popover;

@property (nonatomic, strong) NSArray *selectedArray;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@end


static NSString *province = @"province";
static NSString *city = @"city";
static NSString *county = @"county";
@implementation AddNewTableController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view addSubview:self.backgroundView];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:2.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundView.alpha = 1;
        self.backgroundView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    // Do any additional setup after loading the view.
}

-(void)getMianLocationButtonClicked:(id)sender{
    self.popoveTableData = [self getAreas];
    NSDictionary *tempDict =  [self getAreas];
    CGPoint startPoint ;
    if ([_proviceButton isEqual:sender]) {
        self.provinceArray = tempDict.allKeys;
        startPoint = CGPointMake(CGRectGetMidX(_proviceButton.frame) + 10, CGRectGetMaxY(self.zoneField.frame));
        self.popoverTable.tagString = province;
        [self.popover showAtPoint:startPoint popoverPostion:CKPopoverPositionDown withContentView:self.popoverTable inView:self.backgroundView];
        [self.popoverTable reloadData];
    }else if ([_cityButton isEqual:sender]){
        self.popoverTable.tagString = city;
        startPoint = CGPointMake(CGRectGetMidX(_cityButton.frame) + 10, CGRectGetMaxY(self.zoneField.frame));
        [self.popover showAtPoint:startPoint popoverPostion:CKPopoverPositionDown withContentView:self.popoverTable inView:self.backgroundView];
        [self.popoverTable reloadData];
        
    }else if ([_countyButton isEqual:sender]){
        self.popoverTable.tagString = county;
        startPoint = CGPointMake(CGRectGetMidX(_countyButton.frame) + 10, CGRectGetMaxY(self.zoneField.frame));
        [self.popover showAtPoint:startPoint popoverPostion:CKPopoverPositionDown withContentView:self.popoverTable inView:self.backgroundView];
        [self.popoverTable reloadData];
        
    }else{
        
        return;
    }
}

-(void)confirmButtonClicked{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"tableId"] = [NSString stringWithFormat:@"%ld", self.tableId];
    params[@"accountId"] = @"1";
    params[@"createDate"] = @"2015/5/8";
    params[@"address"] = [NSString stringWithFormat:@"%@%@%@%@", self.proviceButton.titleLabel.text, self.cityButton.titleLabel.text, self.countyButton.titleLabel.text, self.addressField.text];
    params[@"logitude"] = @"";
    params[@"latitude"] = @"";
    params[@"principalName"] = self.principalNameField.text;
    params[@"title"] = self.name.text;
    NSLog(@"%@",self.addressField.text);
    [HTTPTool postWithSourceString:@"CreateNewTable.ashx" params:params success:^(id JSON) {
        if (self.finishedCreateTable) {
            self.finishedCreateTable(JSON);
            [self showSuccessWithStatsu:@"表单新建成功" onView:nil completion:nil];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)cancelButtonClicked:(UIButton *)sender{
    if (self.dismissButtonClicked) {
        self.dismissButtonClicked((UIButton *)sender);
    }
}

-(NSDictionary *)getAreas{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Address" withExtension:@"plist"];
    return  [NSDictionary dictionaryWithContentsOfURL:url];
}

#pragma UITableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView.tagString isEqualToString:province]) {
        return self.provinceArray.count;
    }else if ([tableView.tagString isEqualToString:city]){
        return self.cityArray.count;
    }else if ([tableView.tagString isEqualToString:county]){
        return self.townArray.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifiler = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifiler];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifiler];
    }
    if ([tableView.tagString isEqualToString:province]) {
        cell.textLabel.text = self.provinceArray[indexPath.row];
    }else if ([tableView.tagString isEqualToString:city]){
        cell.textLabel.text = self.cityArray[indexPath.row];
    }else if ([tableView.tagString isEqualToString:county]){
        cell.textLabel.text = self.townArray[indexPath.row];
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView.tagString isEqualToString:province]) {
        self.selectedArray = [self.popoveTableData objectForKey:[self.provinceArray objectAtIndex: indexPath.row]];
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        
        [self.proviceButton setTitle:self.provinceArray[indexPath.row] forState:UIControlStateNormal];
        [self.popover dismiss];
    }else if ([tableView.tagString isEqualToString:city]){
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:indexPath.row]];
        
        [self.cityButton setTitle:self.cityArray[indexPath.row] forState:UIControlStateNormal];
        [self.popover dismiss];
    }else if ([tableView.tagString isEqualToString:county]){
        [self.countyButton setTitle:self.townArray[indexPath.row] forState:UIControlStateNormal];
        [self.popover dismiss];
    }
}

#pragma getter and setter
-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/2, ScreenHeight/2)];
        _backgroundView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
        _backgroundView.backgroundColor = [UIColor whiteColor];
        _backgroundView.layer.cornerRadius = 5;
        _backgroundView.layer.masksToBounds = YES;
        [_backgroundView addSubview:self.zoneField];
        
        _backgroundView.alpha = 0;
        _backgroundView.transform = CGAffineTransformMakeScale(0.0, 0.0);
    
        [_backgroundView addSubview:self.name];
        [_backgroundView addSubview:self.addressField];
        [_backgroundView addSubview:self.name];
        [_backgroundView addSubview:self.principalNameField];
        [_backgroundView addSubview:self.cancelButton];
        [_backgroundView addSubview:self.confirmButton];
    }
    return _backgroundView;
}

-(UITextField *)zoneField{
    if (!_zoneField) {
        CGFloat textFieldsH = 50.0f;
        UILabel *bgView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/2, 60)];
        bgView.text = @"添加新表";
        bgView.textAlignment = NSTextAlignmentCenter;
        bgView.backgroundColor = [UIColor orangeColor];
        [self.backgroundView addSubview:bgView];
        CGRect labelRect = CGRectMake(0, 0, 100, textFieldsH);
        
        _zoneField = [[UITextField alloc]initWithFrame: CGRectMake(0, 60, ScreenWidth/2, textFieldsH)];
        UILabel *mainLocation = [[UILabel alloc]initWithFrame:labelRect];
        mainLocation.text = @"  所在区域:";
        
        _zoneField.leftView = mainLocation;
        _zoneField.leftViewMode = UITextFieldViewModeAlways;
        
        CGFloat mainLocationButtonW = (ScreenWidth/2 - 80)/3.0 - 2;
        _proviceButton = [[ArrowButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mainLocation.frame), 0, mainLocationButtonW, textFieldsH)];
        [_proviceButton setTitle:@"省" forState:UIControlStateNormal];
        [_proviceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_proviceButton addTarget:self action:@selector(getMianLocationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_proviceButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_zoneField addSubview:_proviceButton];
        
        _cityButton = [[ArrowButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_proviceButton.frame), 0, mainLocationButtonW, textFieldsH)];
        [_cityButton setTitle:@"市" forState:UIControlStateNormal];
        [_cityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cityButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_cityButton addTarget:self action:@selector(getMianLocationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_zoneField addSubview:_cityButton];
        
        _countyButton = [[ArrowButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_cityButton.frame), 0, mainLocationButtonW, textFieldsH)];
        [_countyButton setTitle:@"县、区" forState:UIControlStateNormal];
        [_countyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_countyButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_countyButton addTarget:self action:@selector(getMianLocationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_zoneField addSubview:_countyButton];
    }
    
    return _zoneField;
}

-(UITextField *)addressField{
    if (!_addressField) {
        _addressField = [UIManage createTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(self.zoneField.frame), ScreenWidth/2, 50) placeholder:@"请输入商品名称" textFieldDelegate:self LeftLabelText:@"  详细地址" leftLabelFrame:CGRectMake(0, 0, 100, 50) cornerRadius:0];
    }
    return _addressField;
}

-(UITextField *)name{
    if (!_name) {
        _name = [UIManage createTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(self.addressField.frame), ScreenWidth/2, 50) placeholder:@"请输入表格名称" textFieldDelegate:self LeftLabelText:@"  表格名字" leftLabelFrame:CGRectMake(0, 0, 100, 50) cornerRadius:0];
    }
    return _name;
}

-(UITextField *)principalNameField{
    if (!_principalNameField) {
        _principalNameField = [UIManage createTextFieldWithFrame:CGRectMake(0, CGRectGetMaxY(self.name.frame), ScreenWidth/2, 50) placeholder:@"请输入单位负责人名字" textFieldDelegate:self LeftLabelText:@"  单位负责人" leftLabelFrame:CGRectMake(0, 0, 100, 50) cornerRadius:0];
    }
    return _principalNameField;
}

-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[ UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.principalNameField.frame)+70, ScreenWidth/4, 60)];
        [_cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.backgroundColor = [UIColor orangeColor];
    }
    return _cancelButton;
}

-(UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [[ UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.cancelButton.frame), CGRectGetMaxY(self.principalNameField.frame) + 70, ScreenWidth/4, 60)];
        [_confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton setTitle:@"创建" forState:UIControlStateNormal];
        _confirmButton.backgroundColor = [UIColor orangeColor];
    }
    return _confirmButton;
}

-(CKPopover *)popover{
    if (!_popover) {
        _popover = [[CKPopover alloc]init];
        _popover.animationSpring = YES;
        _popover.maskType = CKPopoverMaskTypeNone;
    }
    return _popover;
}


-(UITableView*)popoverTable{
    if (!_popoverTable) {
        _popoverTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 180, 250) style:UITableViewStylePlain];
        _popoverTable.delegate = self;
        _popoverTable.dataSource = self;
        _popoverTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _popoverTable.backgroundColor = RGBACOLOR(100, 100,100, 0.5);
    }
    return _popoverTable;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
