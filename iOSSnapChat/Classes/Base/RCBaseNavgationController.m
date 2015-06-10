//
//  RCBaseNavgationController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/9.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCBaseNavgationController.h"

@interface RCBaseNavgationController ()

@end

@implementation RCBaseNavgationController

+ (void)initialize {
    //设置导航条通用属性
    [[UINavigationBar appearance] setBarTintColor:[UIColor purpleColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
