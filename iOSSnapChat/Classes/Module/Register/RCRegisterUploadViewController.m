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

#pragma mark - Utility
- (void)setUpUI {
    self.arrowTitle = @"Upload photo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //背景
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kRCScreenWidth, (kRCScreenHeight - 64) * 0.6)];
    backGroundImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:backGroundImageView];
    //文字
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(backGroundImageView.frame) + 20, kRCScreenWidth - 40, 80)];
    textLabel.numberOfLines = 0;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = @"In order to more easy to find a friend, and ensure the authenticity of the photo, we need you to upload the photos";
    [self.view addSubview:textLabel];
    //按钮
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraButton.frame = CGRectMake(20, CGRectGetMaxY(textLabel.frame) +20, kRCScreenWidth - 40, 44);
    [cameraButton setBackgroundColor:kRCRGBAColor(30, 190, 205, 1)];
    [cameraButton addTarget:self action:@selector(cameraDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cameraDidClick {
    UIAlertController *uploadAlertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    kRCWeak(self);
    //打开相机
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
            photoPicker.delegate = self;
            photoPicker.allowsEditing = YES;
            photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:photoPicker animated:YES completion:nil];
        } else {
            NSLog(@"无法启动相机");
        }
    }];
    //打开相册
    UIAlertAction *galleryAction = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController *cameraVc = [[UIImagePickerController alloc] init];
        cameraVc.delegate = self;
        [cameraVc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [weakself presentViewController:cameraVc animated:YES completion:nil];
    }];
    [uploadAlertVc addAction:cameraAction];
    [uploadAlertVc addAction:galleryAction];
    
    [self presentViewController:uploadAlertVc animated:YES completion:nil];
}

#pragma mark - <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedGalleryPhoto = info[UIImagePickerControllerOriginalImage];
    kRCWeak(self);
    [self dismissViewControllerAnimated:YES completion:^{
        RCRegisterPhotoDisplayViewController *registerPhotoDisplayVc = [[RCRegisterPhotoDisplayViewController alloc] init];
        registerPhotoDisplayVc.selectedGalleryPhoto = selectedGalleryPhoto;
#warning 此处需要修改
        weakself.modalPresentationStyle = UIModalPresentationCurrentContext;
        [weakself.navigationController pushViewController:registerPhotoDisplayVc animated:YES];
    }];
}

@end
