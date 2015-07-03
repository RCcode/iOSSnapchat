//
//  RCLoginForgetPasswordViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/13.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCLoginForgetPasswordViewController.h"

//主界面约束
#define kRCLoginForgetPasswordEmailFieldTopConstant kRCAdaptationHeight(128)
#define kRCLoginForgetPasswordEmailFieldLeftConstant kRCAdaptationWidth(34)
#define kRCLoginForgetPasswordEmailFieldRightConstant kRCAdaptationWidth(34)
#define kRCLoginForgetPasswordEmailFieldHeightConstant kRCAdaptationHeight(100)

#define kRCLoginForgetPasswordSeparatorLineTopConstant 0
#define kRCLoginForgetPasswordSeparatorLineLeftConstant 0
#define kRCLoginForgetPasswordSeparatorLineRightConstant 0
#define kRCLoginForgetPasswordSeparatorLineHeightConstant 1

#define kRCLoginForgetPasswordMsgLabelBottomConstant kRCAdaptationHeight(16)
#define kRCLoginForgetPasswordMsgLabelLeftConstant kRCAdaptationWidth(34)

#define kRCLoginForgetPasswordRetrieveButtonBottomConstant (252 + kRCAdaptationHeight(72))
#define kRCLoginForgetPasswordRetrieveButtonLeftConstant kRCAdaptationWidth(34)
#define kRCLoginForgetPasswordRetrieveButtonRightConstant kRCAdaptationWidth(34)
#define kRCLoginForgetPasswordRetrieveButtonHeightConstant kRCAdaptationHeight(78)

@interface RCLoginForgetPasswordViewController () <UINavigationControllerDelegate>
{
    //Controller
    UITextField *_emailField;
    UIView *_emailSeparatorLine;
    UILabel *_msgLabel;
    UIButton *_retrieveButton;
}

@end

@implementation RCLoginForgetPasswordViewController

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
    emailField.placeholder = kRCLocalizedString(@"LoginForgetPasswordEmailPlaceholder");
    [self.view addSubview:emailField];
    _emailField = emailField;
    
    UIView *emailSeparatorLine = [[UIView alloc] init];
    emailSeparatorLine.backgroundColor = kRCSystemLightgray;
    [self.view addSubview:emailSeparatorLine];
    _emailSeparatorLine = emailSeparatorLine;
    
    UILabel *msgLabel = [[UILabel alloc] init];
    msgLabel.font = kRCSystemFont(14);
    msgLabel.textColor = kRCDefaultBlue;
    msgLabel.numberOfLines = 0;
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.text = kRCLocalizedString(@"LoginForgetPasswordDescriptionTitle");
    [self.view addSubview:msgLabel];
    _msgLabel = msgLabel;

    UIButton *retrieveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [retrieveButton setBackgroundColor:kRCDefaultBlue];
    [retrieveButton setTitle:kRCLocalizedString(@"LoginForgetPasswordRetrieveButtonTitle") forState:UIControlStateNormal];
    [retrieveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [retrieveButton addTarget:self action:@selector(retrieveButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:retrieveButton];
    _retrieveButton = retrieveButton;
}

- (void)addConstraint {
    [_emailField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCLoginForgetPasswordEmailFieldTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCLoginForgetPasswordEmailFieldLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCLoginForgetPasswordEmailFieldRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCLoginForgetPasswordEmailFieldHeightConstant]];
    
    [_emailSeparatorLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailSeparatorLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_emailField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCLoginForgetPasswordSeparatorLineTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailSeparatorLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCLoginForgetPasswordSeparatorLineLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailSeparatorLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:kRCLoginForgetPasswordSeparatorLineRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailSeparatorLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:kRCLoginForgetPasswordSeparatorLineHeightConstant]];
    
    [_msgLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_msgLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_retrieveButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:-kRCLoginForgetPasswordMsgLabelBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_msgLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCLoginForgetPasswordMsgLabelLeftConstant]];
    
    [_retrieveButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_retrieveButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCLoginForgetPasswordRetrieveButtonBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_retrieveButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCLoginForgetPasswordRetrieveButtonLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_retrieveButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCLoginForgetPasswordRetrieveButtonRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_retrieveButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCLoginForgetPasswordRetrieveButtonHeightConstant]];
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    self.popVc.isAutoLogin = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)retrieveButtonDidClicked {
#warning not finish
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
