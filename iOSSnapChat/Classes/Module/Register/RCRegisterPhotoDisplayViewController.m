//
//  RCRegisterPhotoDisplayViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/11.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegisterPhotoDisplayViewController.h"
#import "RCRegisterUploadPhotoViewController.h"

@interface RCRegisterPhotoDisplayViewController ()

@end

@implementation RCRegisterPhotoDisplayViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self modifyNavgationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility
- (void)setUpUI {
    self.arrowTitle = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //背景照片
    UIImageView *backGroudPhotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kRCScreenWidth, kRCScreenHeight - 64)];
    backGroudPhotoImageView.image = _selectedGalleryPhoto;
    [self.view addSubview:backGroudPhotoImageView];
    
    //顶部阴影
    UIView *topCover = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kRCScreenWidth, 64)];
    topCover.backgroundColor = [UIColor blackColor];
    topCover.alpha = 0.4;
    [self.view addSubview:topCover];
    
    //底部阴影
    UIView *bottomCover = [[UIView alloc] initWithFrame:CGRectMake(0, kRCScreenHeight - (kRCScreenHeight - 64 - 64) / 4, kRCScreenWidth, (kRCScreenHeight - 64 - 64) / 4)];
    bottomCover.backgroundColor = [UIColor blackColor];
    bottomCover.alpha = 0.4;
    [self.view addSubview:bottomCover];
    
    //水平分割线
    for (int i = 0; i < 4; ++ i) {
        UIView *horizontalSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 64 + (kRCScreenHeight - 64 - 64) / 4 * i, kRCScreenWidth, 0.5)];
        horizontalSeparatorLine.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:horizontalSeparatorLine];
    }
    
    //垂直分割线
    for (int i = 0; i < 2; ++ i) {
        UIView *verticalSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(kRCScreenWidth / 3 * (i + 1), 64 + 64, 0.5, kRCScreenHeight - 64 - 64 - (kRCScreenHeight - 64 - 64) / 4)];
        verticalSeparatorLine.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:verticalSeparatorLine];
    }
}

- (void)modifyNavgationBar {
#warning 修改frame font/带有done的控制器都要修改
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 0, 44, 44);
    [doneButton setTitle:kRCLocalizedString(@"RegisterInfoDone") forState:UIControlStateNormal];
    doneButton.titleLabel.font = kRCBoldSystemFont(17);
    [doneButton addTarget:self action:@selector(doneButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    self.navigationItem.rightBarButtonItem = doneButtonItem;
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doneButtonDidClicked {
    RCRegisterUploadPhotoViewController *registerUploadPhotoVc = [[RCRegisterUploadPhotoViewController alloc] init];
    registerUploadPhotoVc.selectedGalleryPhoto = _selectedGalleryPhoto;
    [self.navigationController pushViewController:registerUploadPhotoVc animated:YES];
}

@end
