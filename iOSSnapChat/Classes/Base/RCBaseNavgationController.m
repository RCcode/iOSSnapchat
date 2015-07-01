//
//  RCBaseNavgationController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/9.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCBaseNavgationController.h"

//导航栏系统按钮
#define kRCAppearanceNavgationBarButtonItemAttribute @{NSForegroundColorAttributeName: kRCDefaultWhite, NSFontAttributeName: kRCBoldSystemFont(17)}
//导航栏标题
#define kRCAppearanceNavgationBarTitleTextAttribute @{NSForegroundColorAttributeName: kRCDefaultWhite, NSFontAttributeName: kRCBoldSystemFont(17)}

@interface RCBaseNavgationController ()

@end

@implementation RCBaseNavgationController

+ (void)initialize {
    //设置导航条通用属性
    [[UINavigationBar appearance] setBarTintColor:kRCDefaultPurple];
    [[UINavigationBar appearance] setTintColor:kRCDefaultWhite];
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
