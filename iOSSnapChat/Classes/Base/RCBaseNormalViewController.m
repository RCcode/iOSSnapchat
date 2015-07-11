//
//  RCBaseNormalViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/25.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCBaseNormalViewController.h"

@interface RCBaseNormalViewController ()

@end

@implementation RCBaseNormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RCNavgationItemButton *arrowBackButton = [[RCNavgationItemButton alloc] init];
    arrowBackButton.frame = kRCDefaultNacgationBarItemFrame;
    [arrowBackButton setImage:kRCImage(@"back") forState:UIControlStateNormal];
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
