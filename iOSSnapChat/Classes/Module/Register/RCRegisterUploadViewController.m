//
//  RCRegisterUploadViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/11.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegisterUploadViewController.h"
#import "RCRegisterPhotoDisplayViewController.h"

@interface RCRegisterUploadViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation RCRegisterUploadViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Utility
- (void)setUpUI {
    self.arrowTitle = @"Upload photo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //背景
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kRCScreenWidth, (kRCScreenHeight - 64) * 0.6)];
    backGroundImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:backGroundImageView];
    
    //描述文本
    NSString *descriptionText = @"In order to more easy to find a friend, and ensure the authenticity of the photo, we need you to upload the photos";
    CGSize size = [descriptionText sizeForLineWithSize:CGSizeMake(kRCScreenWidth - 40, MAXFLOAT) Attributes:@{NSFontAttributeName: kRCSystemFont(14)}];
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(backGroundImageView.frame) + 20, size.width, size.height)];
    msgLabel.font = kRCSystemFont(14);
    msgLabel.numberOfLines = 0;
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.text = descriptionText;
    [self.view addSubview:msgLabel];
    
    //相机按钮
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraButton.frame = CGRectMake(20, CGRectGetMaxY(msgLabel.frame) +20, kRCScreenWidth - 40, 44);
    [cameraButton setBackgroundColor:kRCSystemDefaultBlue];
    [cameraButton addTarget:self action:@selector(cameraDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cameraDidClick {
    UIAlertController *uploadAlertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //获取相机图片
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acquireCamaraGalleryPhoto:) name:kRCCameraGalleryNotification object:nil];
        [[RCCamerGalleryManager shareManager] openCameraAcquirePhotoWithCurrentViewController:self];
    }];
    
    //获取相册图片
    UIAlertAction *galleryAction = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acquireCamaraGalleryPhoto:) name:kRCCameraGalleryNotification object:nil];
        [[RCCamerGalleryManager shareManager] openGalleryAcquirePhotoWithCurrentViewController:self];
    }];
    
    [uploadAlertVc addAction:cameraAction];
    [uploadAlertVc addAction:galleryAction];
    [self presentViewController:uploadAlertVc animated:YES completion:nil];
}

- (void)acquireCamaraGalleryPhoto:(NSNotification *)notice {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    UIImage *selectedGalleryPhoto = notice.userInfo[kRCCameraGalleryNotification];
    RCRegisterPhotoDisplayViewController *registerPhotoDisplayVc = [[RCRegisterPhotoDisplayViewController alloc] init];
    registerPhotoDisplayVc.selectedGalleryPhoto = selectedGalleryPhoto;
    [self.navigationController pushViewController:registerPhotoDisplayVc animated:YES];
}

@end
