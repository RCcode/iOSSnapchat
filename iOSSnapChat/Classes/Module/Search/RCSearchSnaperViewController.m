//
//  RCSearchSnaperViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/13.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCSearchSnaperViewController.h"

@interface RCSearchSnaperViewController ()

@end

@implementation RCSearchSnaperViewController

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
    self.view.backgroundColor = [UIColor yellowColor];
}

#pragma mark - Action
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
