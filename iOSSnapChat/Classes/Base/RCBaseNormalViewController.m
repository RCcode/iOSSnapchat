//
//  RCBaseNormalViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/25.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCBaseNormalViewController.h"

#define kBackButtonF CGRectMake(0, 0, 44, 44)

@interface RCBaseNormalViewController ()

@end

@implementation RCBaseNormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //ButtonItem
    UIButton *arrowBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    arrowBackButton.frame = kBackButtonF;
    [arrowBackButton setImage:kRCImage(@"") forState:UIControlStateNormal];
    [arrowBackButton addTarget:self action:@selector(arrowBackDidClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *arrowBackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:arrowBackButton];
    self.navigationItem.leftBarButtonItem = arrowBackButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
