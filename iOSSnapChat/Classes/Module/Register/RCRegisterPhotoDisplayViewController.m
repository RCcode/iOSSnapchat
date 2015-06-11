//
//  RCRegisterPhotoDisplayViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/11.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegisterPhotoDisplayViewController.h"

@interface RCRegisterPhotoDisplayViewController ()

@end

@implementation RCRegisterPhotoDisplayViewController

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
    self.arrowTitle = @"1";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
