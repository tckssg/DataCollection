//
//  MenuListViewController.m
//  DataCollection
//
//  Created by ChuanKai on 15/3/16.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "MenuListViewController.h"
#import "MGSwipeButton.h"
#import "HeadView.h"
#import "MenuGroup.h"
#import "ChildMenuViewController.h"
#import "TextInputViewController.h"
#import "DataModels.h"
#import "AddNewTableController.h"
#import "TableInfoView.h"
#import "CKPopover.h"

@interface MenuListViewController ()<HeadViewDelegate,UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>{
    NSArray *_mainMenuData;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *childView;
@property (nonatomic, strong) NSMutableArray *getedData;
@property (nonatomic, strong) NSMutableArray *tableOne;
@property (nonatomic, strong) NSMutableArray *tableTwo;
@property (nonatomic, strong) NSMutableArray *tableThree;
@property (nonatomic, strong) NSMutableArray *tableFour;
@property (nonatomic, strong) NSMutableArray *tableFive;
@property (nonatomic, strong) NSMutableArray *tableSix;
@property (nonatomic, strong) NSMutableArray *tableSeven;
@property (nonatomic, strong) CKPopover *popover;

@property (nonatomic, strong) AddNewTableController *addNewTableVC;
@end

@implementation MenuListViewController

- (void)viewDidLoad {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [super viewDidLoad];
    [self loadData];
    [self requestData];
    [self addHeadView];
    [self addMenueTableView];
   
    // Do any additional setup after loading the view.
}

-(void)requestData{
    [CKCKProgress showNetworkLoadingWithStatus:@"正在加载数据，请稍等..." onView:nil];
    [HTTPTool getWithSourceString:@"GetData.ashx?accountId=1" success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            if ([[JSON valueForKey:@"State"] isEqualToString:@"0"]) {
                
                [CKCKProgress dismissWithCompletion:nil];
                
                if (self.childView) {
                    [self.childView removeFromSuperview];
                    self.childView = nil;
                }
                
                [self.tableOne removeAllObjects];
                [self.tableTwo removeAllObjects];
                [self.tableThree removeAllObjects];
                [self.tableFour removeAllObjects];
                [self.tableFive removeAllObjects];
                [self.tableSix removeAllObjects];
                [self.tableSeven removeAllObjects];
                [self.getedData removeAllObjects];
                for (NSDictionary *dict in [JSON valueForKey:@"Data"]) {
                    DataModel *dataModel = [DataModel modelObjectWithDictionary:dict];
                    [self.getedData addObject:dataModel];
                    
                    switch ([dataModel.tableCode integerValue]) {
                        case 1:
                            [self.tableOne addObject:dataModel];
                            break;
                        case 2:
                            [self.tableTwo addObject:dataModel];
                            break;
                        case 3:
                            [self.tableThree addObject:dataModel];
                            break;
                        case 4:
                            [self.tableFour addObject:dataModel];
                            break;
                        case 5:
                            [self.tableFive addObject:dataModel];
                            break;
                        case 6:
                            [self.tableSix addObject:dataModel];
                            break;
                        case 7:
                            [self.tableSeven addObject:dataModel];
                            break;
                        default:
                            break;
                    }
                    [self.tableView reloadData];
                }
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)addMenueTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth/3, ScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}

-(void)addHeadView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    headView.backgroundColor = kColor(64, 64, 87);
    [self.view addSubview:headView];
    
    UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/3-100, 20, 100, 44)];
    [saveButton setTitle:@"刷新" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:saveButton];
    
}

-(void) refreshTable{
    [self requestData];
}

-(void)loadData{
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"Menu.plist" withExtension:nil];
    NSArray *tempArray = [NSArray arrayWithContentsOfURL:url];
    NSMutableArray *tpArray = [NSMutableArray array];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:tempArray options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    for (NSDictionary *dict in tempArray) {
        MenuGroup *menuGroup = [MenuGroup menuGroupWithDict:dict];
        [tpArray addObject:menuGroup];
    }
    _mainMenuData = tpArray;
}

//-(NSArray *)createRightButton{
//    MGSwipeButton *deleteButton = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor]];
//    return [NSArray arrayWithObject:deleteButton];
//}

#pragma UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _mainMenuData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSMutableArray *array = [NSMutableArray array];
//    for (NSString *str in menuGroup.childMenu) {
//        [array addObject:str];
//    }
    MGSwipeTableCell *cell;
    static NSString *cellIdentifier = @"cell";
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MGSwipeTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
    }
    switch (indexPath.section + 1) {
        case 1:{
            cell.textLabel.text = ((DataModel *)self.tableOne[indexPath.row]).title;
            NSLog(@"%@",((DataModel *)self.tableOne[indexPath.row]).title);
        }
            break;
        case 2:
            cell.textLabel.text = ((DataModel *)self.tableTwo[indexPath.row]).title;
            break;
        case 3:
            cell.textLabel.text = ((DataModel *)self.tableThree[indexPath.row]).title;
            break;
        default:
            break;
    }
//    cell.rightButtons = [self createRightButton];
    MGSwipeSettings *setting = [[MGSwipeSettings alloc]init];
    setting.transition = MGSwipeTransition3D;
    cell.leftSwipeSettings.transition = MGSwipeTransitionStatic;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeadView *headView = [HeadView headViewWithTableView:tableView];
    headView.tableId = section + 1;
    headView.delegate = self;
    headView.menuGroup = _mainMenuData[section];
    headView.frame = CGRectMake(0, 0, ScreenWidth, 40);
    
    headView.infoButtonDidClicked = ^(UIButton *button, NSInteger tableId){
        TableInfoView *infoView = [[TableInfoView alloc]initWithFrame:CGRectMake(0, 0, 320, 300)];
        switch (section + 1) {
            case 1:{
                infoView.dataModel = self.tableOne[0];
            }
                break;
            case 2:{
                infoView.dataModel = self.tableTwo[0];
            }
                break;
            case 3:{
                infoView.dataModel = self.tableThree[0];
            }
                break;
            default:
                break;
        }
        [self.popover showAtPoint:CGPointMake(ScreenWidth/2, ScreenHeight/2 - 150) popoverPostion:CKPopoverPositionDown withContentView:infoView inView:self.view];
    };
    
    headView.addButtonDidClicked = ^(UIButton * button, NSInteger tableId){
        self.addNewTableVC = [[AddNewTableController alloc]init];
        self.addNewTableVC.tableId = tableId;
        [self addChildViewController:self.addNewTableVC];
        
        self.addNewTableVC.view.frame = self.view.bounds;//
         [self.view addSubview:self.addNewTableVC.view];
        
        __weak typeof(self)weakSelf = self;
        self.addNewTableVC.finishedCreateTable = ^(id JSON){
            if (weakSelf.addNewTableVC) {
                weakSelf.addNewTableVC.view.alpha = 1;
                weakSelf.addNewTableVC.view.transform = CGAffineTransformIdentity;
                [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:22.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    weakSelf.addNewTableVC.view.alpha = 0;
                    weakSelf.addNewTableVC.view.transform = CGAffineTransformMakeScale(0, 0);
                } completion:^(BOOL finished) {
                    [weakSelf.addNewTableVC  willMoveToParentViewController:nil];
                    [weakSelf.addNewTableVC.view removeFromSuperview];
                    weakSelf.addNewTableVC.view.hidden = YES;
                    [weakSelf .addNewTableVC removeFromParentViewController];
                    //刷新数据
                    [weakSelf refreshTable];
                }];
            }
        };
        
        self.addNewTableVC.dismissButtonClicked = ^(UIButton *button){
            if (weakSelf.addNewTableVC) {
                weakSelf.addNewTableVC.view.alpha = 1;
                weakSelf.addNewTableVC.view.transform = CGAffineTransformIdentity;
                [UIView animateWithDuration:0.5 animations:^{
                    weakSelf.addNewTableVC.view.alpha = 0;
                    weakSelf.addNewTableVC.view.transform = CGAffineTransformMakeScale(0.001, 0.001);
                } completion:^(BOOL finished) {
                    if (finished) {
                        [weakSelf.addNewTableVC  willMoveToParentViewController:nil];
                        [weakSelf.addNewTableVC.view removeFromSuperview];
                        weakSelf.addNewTableVC.view.hidden = YES;
                        [weakSelf .addNewTableVC removeFromParentViewController];

                    }
                }];
//                [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:22.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//                    weakSelf.addNewTableVC.view.alpha = 0;
//                    weakSelf.addNewTableVC.view.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
//                } completion:^(BOOL finished) {
//                    [weakSelf.addNewTableVC  willMoveToParentViewController:nil];
//                    [weakSelf.addNewTableVC.view removeFromSuperview];
//                    weakSelf.addNewTableVC.view.hidden = YES;
//                    [weakSelf .addNewTableVC removeFromParentViewController];
//                }];
            }
        };
        
        [self.addNewTableVC didMoveToParentViewController:self];
        
    };
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    MenuGroup *menuGroup = _mainMenuData[section];
//    NSInteger count = menuGroup.isOpened ? menuGroup.childMenu.count : 0;
    MenuGroup *menuGroup = _mainMenuData[section];
    NSInteger dataCount = 0;
    for (DataModel *datModel in self.getedData) {
        if ([datModel.tableCode integerValue]-1 == section) {
            dataCount++;
        }
    }
    NSInteger count = menuGroup.isOpened ? dataCount : 0;
    return count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DataModel *cropsData;
    NSArray *tableArray;
    switch (indexPath.section+1) {
        case 1:
            tableArray = self.tableOne;
            cropsData = self.tableOne[indexPath.row];
            break;
        case 2:{
            tableArray = self.tableThree;
            cropsData = self.tableTwo[indexPath.row];
        }
            break;
        case 3:{
            tableArray = self.tableThree;
            cropsData = self.tableThree[indexPath.row];
        }
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        _childView.alpha = 0;
    } completion:^(BOOL finished) {
        [_childView removeFromSuperview];
        _childView = nil;
        if (!_childView) {
            _childView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/3, 0, ScreenWidth - ScreenWidth/3, ScreenHeight)];
            _childView.alpha = 0;
        }
        
        _childView.frame = CGRectMake(ScreenWidth, 0, ScreenWidth - ScreenWidth/3, ScreenHeight);
        ChildMenuViewController *childController = [[ChildMenuViewController alloc]init];
        childController.cropsDetailData = cropsData;
        childController.tableArray = tableArray;
        childController.menuGroup = _mainMenuData[indexPath.section];
        childController.tableViewCellDidClicked = ^(NSDictionary *crops, NSIndexPath *callbackIndexPath, DataModel *cropData){
            TextInputViewController *textInputController;
            if (callbackIndexPath.row == 0) {
                textInputController = [[TextInputViewController alloc]initWithAllCrops:(MenuGroup *)_mainMenuData[indexPath.section] cropsData:cropData];
            }else{
                textInputController = [[TextInputViewController alloc]initWithCrops:crops cropsData:cropData menuGroup:(MenuGroup *)_mainMenuData[indexPath.section] ];
            }
            textInputController.view.frame = CGRectMake(ScreenWidth/3, 0, ScreenWidth/3, ScreenHeight );
            [self addChildViewController:textInputController];
            [_childView addSubview:textInputController.view];
        };
        
        childController.childMenu = ((MenuGroup *)_mainMenuData[indexPath.section]).childMenu;
        childController.indexPath = indexPath;
        [self addChildViewController:childController];
        childController.view.frame = CGRectMake(0, 0, ScreenWidth/3, ScreenHeight);
        [_childView addSubview: childController.view];
        
        
        [self.view addSubview:_childView];
        _childView.frame = CGRectMake(ScreenWidth/3, 0, ScreenWidth - ScreenWidth/3, ScreenHeight);
        
        [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _childView.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }];
    
}

#pragma MGSwipeTableCellDelegate
-(BOOL)swipeTableCell:(MGSwipeTableCell *)cell canSwipe:(MGSwipeDirection)direction{
    return YES;
}

-(NSArray *) swipeTableCell:(MGSwipeTableCell *)cell swipeButtonsForDirection:(MGSwipeDirection)direction swipeSettings:(MGSwipeSettings *)swipeSettings expansionSettings:(MGSwipeExpansionSettings *)expansionSettings{
    swipeSettings.transition = MGSwipeTransitionBorder;
    expansionSettings.buttonIndex = 0;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (direction == MGSwipeDirectionRightToLeft) {
//        expansionSettings.fillOnTrigger = YES;
        expansionSettings.threshold = 1.1;
        
        MGSwipeButton * detail = [MGSwipeButton buttonWithTitle:@"详情" backgroundColor:[UIColor colorWithRed:1.0 green:59/255.0 blue:50/255.0 alpha:1.0] callback:^BOOL(MGSwipeTableCell *sender) {
            NSLog(@"索引是%ld", indexPath.row);
            return NO; //don't autohide to improve delete animation
        }];
        MGSwipeButton * delete = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor colorWithRed:1.0 green:149/255.0 blue:0.05 alpha:1.0] callback:^BOOL(MGSwipeTableCell *sender) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSString *tableId = @"";
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
            NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
            switch (indexPath.section + 1) {
                case 1:{
                    if (indexPath.row <= 3) {
                        [CKCKProgress showErrorWithStatsu:@"删除失败" onView:nil completion:nil];
                        return NO;
                    }
                        tableId = ((DataModel *)self.tableOne[indexPath.row]).internalBaseClassIdentifier;
                }
                    break;
                case 2:{
                    if (indexPath.row <= 1) {
                        [CKCKProgress showErrorWithStatsu:@"删除失败" onView:nil completion:nil];
                        return NO;
                    }
                    tableId = ((DataModel *)self.tableTwo[indexPath.row]).internalBaseClassIdentifier;
                }
                    break;
                case 3:{
                    if (indexPath.row <= 1) {
                        [CKCKProgress showErrorWithStatsu:@"删除失败" onView:nil completion:nil];
                        return NO;
                    }

                    tableId = ((DataModel *)self.tableThree[indexPath.row]).internalBaseClassIdentifier;
                }
                    break;
                case 4:{
                    tableId = ((DataModel *)self.tableFour[indexPath.row]).internalBaseClassIdentifier;
                }
                    break;
                case 5:{
                    tableId = ((DataModel *)self.tableFive[indexPath.row]).internalBaseClassIdentifier;
                }
                    break;
                case 6:{
                    tableId = ((DataModel *)self.tableSix[indexPath.row]).internalBaseClassIdentifier;
                }
                    break;
                case 7:{
                    tableId = ((DataModel *)self.tableSeven[indexPath.row]).internalBaseClassIdentifier;
                }
                    break;
                    
                default:
                    break;
            }
            
            params[@"tableId"] = tableId;
//            [HTTPTool getWithSourceString:@"deletetable.ashx" success:^(id JSON) {
//                if ([[JSON valueForKey:@"Message"] isEqualToString:@"1"]) {
//                    [CKCKProgress showSuccessWithStatsu:@"删除成功" onView:nil completion:^{
//                        [self refreshTable];
//                    }];
//                }else{
//                    [CKCKProgress showErrorWithStatsu:@"删除失败，请重试" onView:nil completion:nil];
//                }
//            } failure:^(NSError *error) {
//                [CKCKProgress showErrorWithStatsu:@"删除失败，请重试" onView:nil completion:nil];
//
//            }];
            [HTTPTool postWithSourceString:@"deletetable.ashx" params:params success:^(id JSON) {
                if ([[JSON valueForKey:@"State"] isEqualToString:@"1"]) {
                    [CKCKProgress showSuccessWithStatsu:@"删除成功" onView:nil completion:^{
                        [self refreshTable];
                    }];
                }else{
                    [CKCKProgress showErrorWithStatsu:@"删除失败，请重试" onView:nil completion:nil];
                }
            } failure:^(NSError *error) {
                [CKCKProgress showErrorWithStatsu:@"删除失败，请重试" onView:nil completion:nil];
            }];
            
            return NO;
        }];
        return @[detail, delete];
    }
    return nil;
}

#pragma getter and setter
-(NSMutableArray *)getedData{
    if (!_getedData) {
        _getedData = [NSMutableArray array];
    }
    return _getedData;
}
-(NSMutableArray *)tableOne{
    if (!_tableOne) {
        _tableOne = [NSMutableArray array];
    }
    return _tableOne;
}
-(NSMutableArray *)tableTwo{
    if (!_tableTwo) {
        _tableTwo = [NSMutableArray array];
    }
    return _tableTwo;
}
-(NSMutableArray *)tableThree{
    if (!_tableThree) {
        _tableThree = [NSMutableArray array];
    }
    return _tableThree;
}
-(NSMutableArray *)tableFour{
    if (!_tableFour) {
        _tableFour = [NSMutableArray array];
    }
    return _tableFour;
}
-(NSMutableArray *)tableFive{
    if (!_tableFive) {
        _tableFive = [NSMutableArray array];
    }
    return _tableFive;
}
-(NSMutableArray *)tableSix{
    if (!_tableSix) {
        _tableSix = [NSMutableArray array];
    }
    return _tableSix;
}
-(NSMutableArray *)tableSeven{
    if (!_tableSeven) {
        _tableSeven = [NSMutableArray array];
    }
    return _tableSeven;
}
-(CKPopover *)popover{
    if (!_popover) {
        _popover = [[CKPopover alloc]init];
        _popover.animationSpring = YES;
        _popover.maskType = CKPopoverMaskTypeBlack;
    }
    return _popover;
}
-(void)headViewDidClicked{
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
