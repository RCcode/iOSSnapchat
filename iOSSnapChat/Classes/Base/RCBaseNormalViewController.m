//
//  RCBaseNormalViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/25.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCBaseNormalViewController.h"

#define kBackButtonF kRCDefaultNacgationBarItemFrame

@interface RCBaseNormalViewController ()

@end

@implementation RCBaseNormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *arrowBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    arrowBackButton.frame = kBackButtonF;
    [arrowBackButton setImage:kRCImage(@"icon_back") forState:UIControlStateNormal];
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
