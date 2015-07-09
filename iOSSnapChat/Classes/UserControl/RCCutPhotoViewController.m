//
//  RCCutPhotoViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/17.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCCutPhotoViewController.h"
#import "ScreenshotBorderView.h"

@interface RCCutPhotoViewController ()
{
    ScreenshotBorderView *_screentshotView;
}

@end

@implementation RCCutPhotoViewController

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
    //剪切控件
    _screentshotView = [[ScreenshotBorderView alloc] initWithFrame:CGRectMake(0, 0, kRCScreenWidth, kRCScreenHeight + 64)];
    _screentshotView.srcImage = _cutImage;
    [self.view addSubview:_screentshotView];
}

- (void)modifyNavgationBar {
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = kRCDefaultNacgationBarItemFrame;
    [doneButton setTitle:kRCLocalizedString(@"RegisterUploadCutPhotoNavigatiTitle") forState:UIControlStateNormal];
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
    UIImage *cutImage = [_screentshotView subImage];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRCCameraGalleryNotification object:nil userInfo:@{kRCCameraGalleryNotification: cutImage}];
}

@end
