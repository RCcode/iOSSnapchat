//
//  RCBaseRegisterLoginViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/12.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCBaseRegisterLoginViewController.h"
#import "RCHomeViewController.h"

//AutoLayout
#define kRRegisterLoginEmailFieldTopConstant kRCAdaptationHeight(128)
#define kRRegisterLoginEmailFieldLeftConstant kRCAdaptationWidth(34)
#define kRRegisterLoginEmailFieldRightConstant kRCAdaptationWidth(34)
#define kRRegisterLoginEmailFieldHeightConstant kRCAdaptationHeight(100)

#define kRRegisterLoginEmailSeparatorLineTopConstant 0
#define kRRegisterLoginEmailSeparatorLineLeftConstant 0
#define kRRegisterLoginEmailSeparatorLineRightConstant 0
#define kRRegisterLoginEmailSeparatorLineHeightConstant 1

#define kRRegisterLoginPasswordFieldTopConstant 0
#define kRRegisterLoginPasswordFieldLeftConstant kRCAdaptationWidth(34)
#define kRRegisterLoginPasswordFieldRightConstant kRCAdaptationWidth(34)
#define kRRegisterLoginPasswordFieldHeightConstant kRCAdaptationHeight(100)

#define kRRegisterLoginPasswordSeparatorLineTopConstant 0
#define kRRegisterLoginPasswordSeparatorLineLeftConstant 0
#define kRRegisterLoginPasswordSeparatorLineRightConstant 0
#define kRRegisterLoginPasswordSeparatorLineHeightConstant 1

#define kRRegisterLoginForgetPasswordButtonTopConstant kRCAdaptationHeight(40)
#define kRRegisterLoginForgetPasswordButtonHeightConstant 20

#define kRRegisterLoginNextButtonBottomConstant (252 + kRCAdaptationHeight(72))
#define kRRegisterLoginNextButtonLeftConstant kRCAdaptationWidth(34)
#define kRRegisterLoginNextButtonRightConstant kRCAdaptationWidth(34)
#define kRRegisterLoginNextButtonHeightConstant kRCAdaptationHeight(78)

@interface RCBaseRegisterLoginViewController ()
{
    //MainUI
    UIView *_emailSeparatorLine;
    UIView *_passwordSeparatorLine;
    UIButton *_forgetPasswordButton;
    
    BOOL _keyboardShow;
}

@end

@implementation RCBaseRegisterLoginViewController

#pragma mark - Setter
- (void)setNextButtonText:(NSString *)nextButtonText {
    _nextButtonText = nextButtonText;
    [_nextButton setTitle:kRCLocalizedString(nextButtonText) forState:UIControlStateNormal];
}

- (void)setShowForgetPassword:(BOOL)showForgetPassword {
    _showForgetPassword = showForgetPassword;
    _forgetPasswordButton.hidden = !showForgetPassword;
}

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self addConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility
- (void)setUpUI {
    UITextField *emailField = [[UITextField alloc] init];
    emailField.placeholder =  kRCLocalizedString(@"RegisterAccountEmailPlaceholder");
    [emailField addTarget:self action:@selector(keyBoardDidShow) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:emailField];
    _emailField = emailField;
    
    UIView *emailSeparatorLine = [[UIView alloc] init];
    emailSeparatorLine.backgroundColor = kRCSystemLightgray;
    [self.view addSubview:emailSeparatorLine];
    _emailSeparatorLine = emailSeparatorLine;
    
    UITextField *passwordField = [[UITextField alloc] init];
    passwordField.placeholder = kRCLocalizedString(@"RegisterAccountPasswordEmailPlaceholder");
    [passwordField addTarget:self action:@selector(keyBoardDidShow) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:passwordField];
    _passwordField = passwordField;
    
    UIView *passwordSeparatorLine = [[UIView alloc] init];
    passwordSeparatorLine.backgroundColor = kRCSystemLightgray;
    [self.view addSubview:passwordSeparatorLine];
    _passwordSeparatorLine = passwordSeparatorLine;
    
    UIButton *forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPasswordButton setTitle:kRCLocalizedString(@"RegisterAccountForgetButtonTitle") forState:UIControlStateNormal];
    [forgetPasswordButton setTitleColor:kRCDefaultBlue forState:UIControlStateNormal];
    forgetPasswordButton.hidden = !_showForgetPassword;
    [forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPasswordButton];
    _forgetPasswordButton = forgetPasswordButton;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setBackgroundColor:kRCDefaultBlue forState:UIControlStateNormal];
    [nextButton setBackgroundColor:kRCDefaultLightgray forState:UIControlStateDisabled];
    [nextButton setTitleColor:kRCDefaultWhite forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    _nextButton = nextButton;
}

- (void)addConstraint {
    [_emailField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRRegisterLoginEmailFieldTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRRegisterLoginEmailFieldLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRRegisterLoginEmailFieldRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRRegisterLoginEmailFieldHeightConstant]];
    
    [_emailSeparatorLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailSeparatorLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_emailField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRRegisterLoginEmailSeparatorLineTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailSeparatorLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRRegisterLoginEmailSeparatorLineLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailSeparatorLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRRegisterLoginEmailSeparatorLineRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailSeparatorLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRRegisterLoginEmailSeparatorLineHeightConstant]];
    
    [_passwordField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_emailSeparatorLine attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRRegisterLoginPasswordFieldTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRRegisterLoginPasswordFieldLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRRegisterLoginPasswordFieldRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRRegisterLoginPasswordFieldHeightConstant]];
    
    [_passwordSeparatorLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordSeparatorLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_passwordField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRRegisterLoginPasswordSeparatorLineTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordSeparatorLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRRegisterLoginPasswordSeparatorLineLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordSeparatorLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRRegisterLoginPasswordSeparatorLineRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_passwordSeparatorLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRRegisterLoginPasswordSeparatorLineHeightConstant]];
    
    [_forgetPasswordButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_forgetPasswordButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_passwordSeparatorLine attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRRegisterLoginForgetPasswordButtonTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_forgetPasswordButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRRegisterLoginForgetPasswordButtonHeightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_forgetPasswordButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [_nextButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_nextButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRRegisterLoginNextButtonBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_nextButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRRegisterLoginNextButtonLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_nextButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRRegisterLoginNextButtonRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_nextButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRRegisterLoginNextButtonHeightConstant]];
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    if (_keyboardShow == NO) {
        [self keyBoardDidHide];
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide) name:UIKeyboardDidHideNotification object:nil];
        [self.view endEditing:YES];
        _keyboardShow = NO;
    }
}

- (void)keyBoardDidHide {
    [[NSNotificationCenter defaultCenter] postNotificationName:kRCSwitchRootVcNotification object:nil userInfo:@{kRCSwitchRootVcNotificationStepKey: @(-2), kRCSwitchRootVcNotificationVcKey: self.navigationController}];
}

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
