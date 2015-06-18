//
//  ChildMenuViewController.m
//  DataCollection
//
//  Created by ChuanKai on 15/3/17.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "ChildMenuViewController.h"
#import "TextInputView.h"
#import "MenuGroup.h"
#import "MGSwipeButton.h"
#import "MGSwipeTableCell.h"
#import "ChartViewController.h"

@interface ChildMenuViewController ()<MGSwipeTableCellDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *childMenuTitle;
@end

@implementation ChildMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *verticalLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, ScreenHeight - 64)];
    verticalLine.backgroundColor = [UIColor grayColor];
    [self.view addSubview:verticalLine];
    
    [self.view addSubview:self.tableView];
    [self addHeadView];
}

-(void)addHeadView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3, 64)];
    headView.backgroundColor = kColor(64, 64, 87);
    [self.view addSubview:headView];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.childMenu.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MGSwipeTableCell *cell;
    static NSString *cellIdentifier = @"cell";
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MGSwipeTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"全部";
    }else{
        cell.textLabel.text = self.childMenuTitle[indexPath.row-1];
    }
    cell.backgroundColor = [UIColor clearColor];
    UIView *cellBackground = [[UIView alloc]initWithFrame:CGRectMake(5, 5, 290, 40)];
    cellBackground.backgroundColor = RGBACOLOR(200, 200, 00, 0.3);
    cellBackground.layer.cornerRadius = 4;
//    [cell.contentView addSubview:cellBackground];
    UIView *selectedBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3, 0)];
    selectedBackgroundView.backgroundColor = [UIColor colorWithRed:18/255.0 green:255.0/255.0 blue:44.0/255.0 alpha:0.5];
    cell.selectedBackgroundView = selectedBackgroundView;
    [cell setHighlighted:YES animated:YES];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableViewCellDidClicked) {
        if (indexPath.row == 0) {
            self.tableViewCellDidClicked(nil, indexPath, self.cropsDetailData);
        }else{
            self.tableViewCellDidClicked([self.childMenu valueForKey:self.childMenuTitle[indexPath.row-1]], indexPath, self.cropsDetailData);
        }
    }
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
            
            ChartViewController *chart = [[ChartViewController alloc]init];
            chart.tableArray = self.tableArray;
            
            if (indexPath.row == 0) {
                NSMutableDictionary *cropsName = [NSMutableDictionary dictionary];
                for (NSString *key in self.menuGroup.childMenu.allKeys) {
                    NSDictionary *nameDict = [self.menuGroup.childMenu valueForKey:key];
                    for (NSString *nameStr in nameDict.allKeys) {
                        cropsName[[nameDict valueForKey:nameStr]] = nameStr;
                    }
                }
                chart.crops = cropsName.allValues;
                [self presentViewController:chart animated:YES completion:nil];
                return NO;
            }
            
            chart.crops = ((NSDictionary *)[self.childMenu valueForKey:self.childMenuTitle[indexPath.row-1]]).allKeys;
            [self presentViewController:chart animated:YES completion:nil];
            return NO; //don't autohide to improve delete animation
        }];
//        MGSwipeButton * delete = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor colorWithRed:1.0 green:149/255.0 blue:0.05 alpha:1.0] callback:^BOOL(MGSwipeTableCell *sender) {
//            
//            return NO;
//        }];
        return @[detail];//, delete];
    }
    return nil;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3, ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }
    return _tableView;
}

-(NSArray*)childMenuTitle{
    if (!_childMenuTitle) {
        _childMenuTitle = self.childMenu.allKeys;
    }
    return _childMenuTitle;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
