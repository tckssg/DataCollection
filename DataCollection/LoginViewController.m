//
//  LoginViewController.m
//  DataCollection
//
//  Created by ChuanKai Tong on 15/4/24.
//  Copyright (c) 2015年 ChuanKai. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTextField.h"
#import "CKCheckBox.h"
#import "UIImage+ImageEffects.m"
#import "AccountModel.h"
#import "MainViewController.h"
#define viewMargin 20


@interface LoginViewController ()
@property (nonatomic, strong) LoginTextField *usernameField;
@property (nonatomic, strong) LoginTextField *passwordField;
@property (nonatomic, strong) CKCheckBox *checkBox;

@property (nonatomic, strong) UIView *backgroundView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.contents = (id)[UIImage imageNamed:@"Background"].CGImage;
    
    _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 250)];
    _backgroundView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
    
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    visualView.frame = _backgroundView.bounds;
    [_backgroundView addSubview:visualView];
    [self.view addSubview:_backgroundView];
    
    
    [self addLoginFieldView];
    AccountModel *account = [AccountManager accountWithFileName:LOGINED_STRING];
    if (account) {
        _usernameField.text =account.userName;
        _passwordField.text = account.password;
    }
    // Do any additional setup after loading the view.
}

-(void)addLoginFieldView{
    CGFloat backgroundW = 320.0f;
//    CGFloat backgroundH = 280.0f;
    
    CGFloat textFieldW = backgroundW - viewMargin * 2;
    CGFloat textFieldH = backgroundW/7;
    CGFloat topMargin = 20;
    
    UIImageView *userFieldImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, textFieldH, textFieldH)];
    userFieldImage.image = [UIImage imageNamed:@"login_img_username"];
    userFieldImage.backgroundColor = RGBACOLOR(255, 255, 255, 0.3f);
    userFieldImage.contentMode = UIViewContentModeCenter;
    
    UIImageView *passworldImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, textFieldH, textFieldH)];
    passworldImage.backgroundColor = RGBACOLOR(255, 255, 255, 0.3f);
    passworldImage.image = [UIImage imageNamed:@"login_img_password"];
    passworldImage.contentMode = UIViewContentModeCenter;
    
    _usernameField = [self createLoginTextFieldWithFrame:CGRectMake(viewMargin, topMargin, textFieldW, textFieldH) leftView:userFieldImage];
    _usernameField.placeholder = @"用户名";
    [_backgroundView addSubview: _usernameField];
    
    _passwordField = [self createLoginTextFieldWithFrame:CGRectMake(viewMargin, CGRectGetMaxY(_usernameField.frame) + viewMargin, textFieldW, textFieldH) leftView:passworldImage];
    _passwordField.placeholder = @"密码";
    _passwordField.secureTextEntry = YES;
    [_backgroundView addSubview: _passwordField];
    
    UIButton *button = [UIManage createButtonFrame:CGRectMake(viewMargin, CGRectGetMaxY(_passwordField.frame) + viewMargin, backgroundW - viewMargin * 2, textFieldH) withBackColor: [UIColor whiteColor] BackgroundImage:nil lightImageView:nil withTarget:self withAction:@selector(loginClick) withTitle:@"登录" withtextfont:[UIFont systemFontOfSize:15.0f] withTextColor:[UIColor blackColor]];
    //    button.layer.cornerRadius = 5.0;
    
    _checkBox = [[CKCheckBox alloc]initWithFrame:CGRectMake(viewMargin, CGRectGetMaxY(button.frame) + viewMargin/2, 100, 20)];
    _checkBox.selected = YES;
    [_checkBox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_checkBox.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_checkBox setTitle:@"记住密码" forState:UIControlStateNormal];
    [_backgroundView addSubview:_checkBox];
    
    [_backgroundView addSubview:button];
    //    [self.view addSubview:loginView];
}

-(void)loginClick{
    NSString *sourceString = [NSString stringWithFormat:@"Login.ashx?name=%@&password=%@", _usernameField.text, _passwordField.text];
    [self showNetworkLoadingWithStatus:@"正在登陆,请稍后" onView:nil];
    [HTTPTool getWithSourceString:sourceString success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            BOOL result = [[JSON valueForKey:@"result"]boolValue];
            if (result) {
                if (_checkBox.selected) {
                    AccountModel *account = [AccountModel modelObjectWithDictionary:@{@"userName":_usernameField.text, @"password":_passwordField.text}];
                    [AccountManager saveAccount:account fileName:LOGINED_STRING];
                }else{
                    [AccountManager deleteAccountWithFileName:LOGINED_STRING];
                }
                [self dismissWithCompletion:^{
                    [self showSuccessWithStatsu:@"登陆成功" onView:nil completion:^{
                        self.view.window.rootViewController = [[MainViewController alloc]init];
                    }];
                }];
            }else{
                [self showErrorWithStatsu:[JSON valueForKey:@"info"] onView:nil completion:nil];
            }
        }
    } failure:^(NSError *error) {
        [self dismissWithCompletion:nil];
        [self showErrorWithStatsu:@"链接超时，登陆失败" onView:nil completion:nil];
    }];
}

-(LoginTextField *) createLoginTextFieldWithFrame :(CGRect)frame leftView :(UIView *) leftView{
    LoginTextField *textField = [[LoginTextField alloc]initWithFrame:frame];
    textField.backgroundColor = [UIColor clearColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.tintColor = [UIColor whiteColor];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.backgroundColor = RGBACOLOR(100, 100, 100, 0.2f);
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:20];
    return textField;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissKeyboard];
}

-(void)dismissKeyboard{
    [_passwordField resignFirstResponder];
    [_usernameField resignFirstResponder];
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
