//
//  ChartViewController.m
//  DataCollection
//
//  Created by ChuanKai Tong on 15/6/4.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "ChartViewController.h"
#import "PNChartDelegate.h"
#import "PNChart.h"
#import "DataModel.h"
#import "CropDetail.h"

@interface ChartViewController ()<PNChartDelegate>
@property (nonatomic) PNLineChart * lineChart;

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *dismissButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 80, 30, 40, 40)];
    [dismissButton setImage:[UIImage imageNamed:@"close_button"] forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
    
    NSArray *cropsArray = self.crops;
    self.view.backgroundColor = [UIColor whiteColor];
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 500.0)];
    self.lineChart.yLabelFormat = @"%1.1f";
    self.lineChart.backgroundColor = [UIColor clearColor];
    [self.lineChart setXLabels:self.crops];
    self.lineChart.showCoordinateAxis = YES;
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    self.lineChart.yFixedValueMax = 300.0;
    self.lineChart.yFixedValueMin = 0.0;
    
    [self.lineChart setYLabels:@[
                                 @"0 亩",
                                 @"50 亩",
                                 @"100 亩",
                                 @"150 亩",
                                 @"200 亩",
                                 @"250 亩",
                                 @"300 亩",
                                 ]
     ];
    
    NSMutableArray *lineArray = [NSMutableArray array];
    
    for (DataModel *dataModel in self.tableArray) {
        NSMutableArray *dataArray = [NSMutableArray array];
//        DataModel *dataModel = self.tableArray[0];
        NSArray *detailArray = dataModel.cropDetail;
        
        for (NSString *key in cropsArray) {
            for (CropDetail *detail in detailArray) {
                if ([detail.cultivarName isEqualToString:key]) {
                    [dataArray addObject:[NSNumber numberWithFloat:[detail.acreage floatValue]]];
                }
            }
        }
        
        //    NSArray * data01Array = @[@60.1, @160.1, @126.4, @0.0, @186.2, @127.2, @176.2];
        NSArray * data01Array = dataArray;
        PNLineChartData *data01 = [PNLineChartData new];
        data01.dataTitle = dataModel.title;
        data01.color = [self randomColor];
        data01.alpha = 0.3f;
        data01.itemCount = data01Array.count;
        data01.inflexionPointStyle = PNLineChartPointStyleCircle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        [lineArray addObject:data01];
    }
    
    self.lineChart.chartData = lineArray;
    [self.lineChart strokeChart];
    self.lineChart.delegate = self;
    
    
    [self.view addSubview:self.lineChart];
    
    self.lineChart.legendStyle = PNLegendItemStyleStacked;
    self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
    self.lineChart.legendFontColor = [UIColor grayColor];
    
    UIView *legend = [self.lineChart getLegendWithMaxWidth:300];
    [legend setFrame:CGRectMake(30, 40, legend.frame.size.width, legend.frame.size.width)];
    [self.view addSubview:legend];
    // Do any additional setup after loading the view.
}

-(void)dismissSelf{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}

- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex pointIndex:(NSInteger)pointIndex{
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}

-(UIColor *)randomColor {
    static BOOL seeded = NO;
    if (!seeded) {
        seeded = YES;
        (time(NULL));
    }
    CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}


- (UIColor *) getColor: (NSString *) hexColor{
    
    unsigned int red, green, blue;
    
    NSRange range;
    
    range.length = 2;
    
    range.location = 0;
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:0.35f];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
