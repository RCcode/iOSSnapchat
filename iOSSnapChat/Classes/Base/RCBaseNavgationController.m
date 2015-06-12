//
//  RCBaseNavgationController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/9.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCBaseNavgationController.h"

//导航栏系统按钮
#define kRCAppearanceNavgationBarButtonItemAttribute @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: kRCBoldSystemFont(17)}
//导航栏标题
#define kRCAppearanceNavgationBarTitleTextAttribute @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: kRCBoldSystemFont(17)}

@interface RCBaseNavgationController ()

@end

@implementation RCBaseNavgationController

+ (void)initialize {
    //设置导航条通用属性
    [[UINavigationBar appearance] setBarTintColor:[UIColor purpleColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //设置导航栏系统按钮通用属性
    [[UIBarButtonItem appearance] setTitleTextAttributes:kRCAppearanceNavgationBarButtonItemAttribute forState:UIControlStateNormal];
    //设置导航栏标题通用属性
    [[UINavigationBar appearance] setTitleTextAttributes:kRCAppearanceNavgationBarTitleTextAttribute];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
