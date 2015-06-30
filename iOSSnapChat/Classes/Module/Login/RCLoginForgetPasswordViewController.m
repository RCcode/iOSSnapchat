//
//  RCLoginForgetPasswordViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/13.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCLoginForgetPasswordViewController.h"

@interface RCLoginForgetPasswordViewController ()
{
    //Controller
    UITextField *_emailField;
    UIView *_emailSeparatorLine;
    UIButton *_retrieveButton;
    UILabel *_msgLabel;
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
    emailSeparatorLine.backgroundColor = kRCDefaultLightgray;
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
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:64 + 10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
    
    [_emailSeparatorLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailSeparatorLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_emailField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailSeparatorLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailSeparatorLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_emailSeparatorLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1]];
    
    [_msgLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_msgLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_emailSeparatorLine attribute:NSLayoutAttributeBottom multiplier:1.0 constant:100]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_msgLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20]];
    
    [_retrieveButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_retrieveButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_msgLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_retrieveButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_retrieveButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_retrieveButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)retrieveButtonDidClicked {
#warning not finish
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
