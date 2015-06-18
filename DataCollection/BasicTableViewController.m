//
//  BasicTableViewController.m
//  ComeHereBusiness
//
//  Created by ChuanKai Tong on 15/4/14.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "BasicTableViewController.h"
#import "UIBarButtonItem+CustomButton.h"
#import "UIViewController+Expand.h"

@interface BasicTableViewController ()

@end

@implementation BasicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back_green"] style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    //    UIImage *image = [UIImage imageNamed:@"back_normal"];
    
    //    UIBarButtonItem *leftBarButtonItem = [self customBarButtonItemWithImageName:@"back_normal" backgroundImageName:nil title:@"返回" target:self action:@selector(popSelf)];
    //    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    negativeSpacer.width = -10;
    //    self.navigationItem.leftBarButtonItems=@[negativeSpacer,leftBarButtonItem];
}

-(void)popSelf{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIBarButtonItem *)customBarButtonItemWithImageName:(NSString *)imageName
                                  backgroundImageName:(NSString *)backgroundImageName
                                                title:(NSString *)title
                                               target:(id)target
                                               action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //    if (backgroundImageName) {//设置背景图片
    //        UIImage *buttonImage = [[UIImage imageNamed:backgroundImageName]
    //                                stretchableImageWithLeftCapWidth:5 topCapHeight:10];
    //        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    //    }
    
    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:16.0]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CGRect buttonFrame = [button frame];
    if (title) {//有标题
        buttonFrame.size.width = [self sizeWithText:title font:[UIFont boldSystemFontOfSize:16.0f] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
        buttonFrame.size.height = 40.0;
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.textColor = [UIColor whiteColor];
    }
    else {
        buttonFrame=CGRectMake(0.0, 0.0, 40.0, 35.0);
        //button.imageEdgeInsets = UIEdgeInsetsMake(0.0,-10,0.0,10.0);
    }
    [button setFrame:buttonFrame];
    
    if (imageName) {//图片
        UIImage *buttonImage = [UIImage imageNamed:imageName];
        [button setImage:buttonImage forState:UIControlStateNormal];
    }
    if (target) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (backgroundImageName) {
        UIImage *buttonImage = [[UIImage imageNamed:backgroundImageName]
                                stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [button setImage:buttonImage forState:UIControlStateHighlighted];
    }
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return buttonItem ;
}


- (KVNProgressConfiguration *)customKVNProgressUIConfiguration
{
    KVNProgressConfiguration *configuration = [[KVNProgressConfiguration alloc] init];
    
    // See the documentation of KVNProgressConfiguration
    configuration.statusColor = [UIColor grayColor];
    configuration.statusFont = [UIFont systemFontOfSize:17.0f];
    configuration.successColor = kColor(34, 252, 19);
    configuration.errorColor = [UIColor redColor];
    configuration.circleStrokeForegroundColor = [UIColor grayColor];
    configuration.circleSize = 80.0f;
    configuration.lineWidth = 6.0f;
    configuration.minimumSuccessDisplayTime = 1.0f;
    configuration.minimumErrorDisplayTime = 1.0f;
    configuration.backgroundType = 0;
    
    return configuration;
}

#pragma public method
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
-(void)showErrorWithStatsu:(NSString *)status onView:(UIView *)superView completion:(KVNCompletionBlock)completion{
    [KVNProgress setConfiguration: [self customKVNProgressUIConfiguration]];
    if (status) {
        [KVNProgress showErrorWithStatus:status onView:superView completion:^{
            if (completion) {
                completion();
            }
        }];
        return;
    }
    [KVNProgress showErrorWithCompletion:^{
        if (completion) {
            completion();
        }
    }];
}

-(void)showSuccessWithStatsu:(NSString *)status onView:(UIView *)superView completion:(KVNCompletionBlock)completion{
    [KVNProgress setConfiguration:[self customKVNProgressUIConfiguration]];
    if (status) {
        [KVNProgress showSuccessWithStatus:status onView:superView completion:^{
            if (completion) {
                completion();
            }
        }];
        return;
    }
    
    [KVNProgress showSuccessWithCompletion:^{
        if (completion) {
            completion();
        }
    }];
}

-(void)showNetworkLoadingWithStatus:(NSString *)status onView:(UIView *)superview{
    KVNProgressConfiguration *configuration = [[KVNProgressConfiguration alloc] init];
    //    configuration.tapBlock = ^(KVNProgress *progress){
    //
    //    }
    [KVNProgress setConfiguration:configuration];
    [KVNProgress setConfiguration:[self customKVNProgressUIConfiguration]];
    if (status) {
        [KVNProgress showWithStatus:status onView:superview];
        return;
    }
    [KVNProgress show];
}

-(void)dismissWithCompletion:(KVNCompletionBlock)completion{
    [KVNProgress dismissWithCompletion:^{
        if (completion) {
            completion();
        }
    }];
}

-(UILabel *)createLabelWithFrame: (CGRect)frame text: (NSString *)text font:(UIFont *)font{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.font = font;
    
    return label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
