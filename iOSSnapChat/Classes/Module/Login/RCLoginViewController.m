//
//  RCLoginViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/12.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCLoginViewController.h"

@interface RCLoginViewController ()

@end

@implementation RCLoginViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self inheritSetting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility
//设置继承属性
- (void)inheritSetting {
    self.arrowTitle = @"Log In";
    self.nextButtonText = @"Log In";
    self.showForegetPassword = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Action
- (void)nextButtonDidClicked {
    NSLog(@"Log In");
//    NSLog(@"email = %@ password = %@", self.emailField.text, self.passwordField.text);
}

- (void)foregetPasswordButtonDidClicked {
    NSLog(@"Foreget password");
}

@end
