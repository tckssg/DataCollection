//
//  ViewController.m
//  DataCollection
//
//  Created by ChuanKai on 15/3/16.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, assign) NSInteger count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHeadView];
    [self addMenueTableView];
    _count = 10;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)addMenueTableView{
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 200, ScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)addHeadView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    headView.backgroundColor = kColor(64, 64, 87);
    [self.view addSubview:headView];
}

#pragma TableView Delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = @"春播农作物面积";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *array = [NSMutableArray array];
    //_count = 15;
    _count++;

    [array addObject:indexPath];
   // [_tableView beginUpdates];
    [_tableView insertRowsAtIndexPaths: array withRowAnimation:UITableViewRowAnimationFade];
//    [_tableView endUpdates];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
