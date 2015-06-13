//
//  RCBaseRegisterLoginViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/12.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCBaseRegisterLoginViewController.h"

@interface RCBaseRegisterLoginViewController ()
{
    UIButton *_nextButton;
    UIButton *_forgetPasswordButton;
    BOOL _keyboardShow;
}

@end

@implementation RCBaseRegisterLoginViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility
- (void)setUpUI {
#warning Modify Frame/Number
    //邮箱
    UITextField *emailField = [[UITextField alloc] initWithFrame:CGRectMake(20, 84, kRCScreenWidth - 40, 44)];
    emailField.placeholder =  kRCLocalizedString(@"RegisterAccountEmailAddress");
    emailField.textAlignment = NSTextAlignmentCenter;
    [emailField addTarget:self action:@selector(keyBoardDidShow) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:emailField];
    _emailField = emailField;
    
    //邮箱分割线
    UIView *emailSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(emailField.frame), kRCScreenWidth, 1)];
    emailSeparatorLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:emailSeparatorLine];
    
    //密码
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(emailField.frame) + 20, kRCScreenWidth - 40, 44)];
    passwordField.placeholder = kRCLocalizedString(@"RegisterAccountPassword");
    passwordField.textAlignment = NSTextAlignmentCenter;
    [passwordField addTarget:self action:@selector(keyBoardDidShow) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:passwordField];
    _passwordField = passwordField;
    
    //密码分割线
    UIView *passwordSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(passwordField.frame), kRCScreenWidth, 1)];
    passwordSeparatorLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:passwordSeparatorLine];
    
    //忘记密码按钮
    UIButton *forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPasswordButton.frame = CGRectMake(60, CGRectGetMaxY(passwordField.frame) + 10, kRCScreenWidth - 120, 44);
    [forgetPasswordButton setTitle:@"Forgot Your Password" forState:UIControlStateNormal];
    [forgetPasswordButton setTitleColor:kRCSystemDefaultBlue forState:UIControlStateNormal];
    forgetPasswordButton.hidden = !_showForgetPassword;
    [forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPasswordButton];
    _forgetPasswordButton = forgetPasswordButton;
    
    //Confirm按钮
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(20, kRCScreenHeight - 216 - 40 - 30 - 20, kRCScreenWidth - 40, 40);
    [nextButton setBackgroundColor:kRCSystemDefaultBlue];
    [nextButton setTitle:@"Default" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    _nextButton = nextButton;
}

- (void)setNextButtonText:(NSString *)nextButtonText {
    _nextButtonText = nextButtonText;
    [_nextButton setTitle:kRCLocalizedString(nextButtonText) forState:UIControlStateNormal];
}

- (void)setShowForgetPassword:(BOOL)showForgetPassword {
    _showForgetPassword = showForgetPassword;
    _forgetPasswordButton.hidden = !showForgetPassword;
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    if (_keyboardShow == NO) {
        [self keyBoardDidHid];
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHid) name:UIKeyboardDidHideNotification object:nil];
        [self.view endEditing:YES];
        _keyboardShow = NO;
    }
}

//键盘消失
- (void)keyBoardDidHid {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//键盘出现
- (void)keyBoardDidShow {
    _keyboardShow = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    _keyboardShow = NO;
}

- (void)nextButtonDidClicked {}

- (void)forgetPasswordButtonDidClicked {}

@end
