//
//  MainViewController.m
//  DataCollection
//
//  Created by ChuanKai on 15/3/17.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "MainViewController.h"
#import "MenuListViewController.h"
#import "ChildMenuViewController.h"
#import "UIImage+ImageEffects.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initChildController];
    // Do any additional setup after loading the view.
}

-(void)initChildController{
//    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    backgroundView.image = [UIImage imageNamed:@"Background"];
//    //backgroundView.image = [UIImage imageNamed:@"background_main"];
//    backgroundView.contentMode =UIViewContentModeScaleAspectFit;
//    backgroundView.userInteractionEnabled =YES;
//    [self.view addSubview:backgroundView];
//    
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
//    effectView.frame = self.view.bounds;
//    effectView.alpha = 1;
//    [self.view addSubview:effectView];
    self.view.layer.contents = (id)[[UIImage imageNamed:@"Background"]applyLightEffect].CGImage;
    
    MenuListViewController *menuListController = [[MenuListViewController alloc]init];
    [self addChildViewController:menuListController];
    [self.view addSubview:menuListController.view];
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
