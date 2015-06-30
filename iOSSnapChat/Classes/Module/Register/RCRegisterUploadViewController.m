//
//  RCRegisterUploadViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/11.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegisterUploadViewController.h"
#import "RCRegisterUploadPhotoViewController.h"

@interface RCRegisterUploadViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    //Control
    UIImageView *_backGroundImageView;
    UIView *_separatorLine;
    UILabel *_msgLabel;
    RCCameraButton *_cameraButton;
}

@end

@implementation RCRegisterUploadViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self inheritSetting];
    [self setUpUI];
    [self addConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Utility
- (void)inheritSetting {
    self.title = kRCLocalizedString(@"RegisterUploadNavigationUploadTitle");
}

- (void)setUpUI {
    UIImageView *backGroundImageView = [[UIImageView alloc] init];
    backGroundImageView.image = kRCImage(@"shili");
    [self.view addSubview:backGroundImageView];
    _backGroundImageView = backGroundImageView;
    
    UIView *separatorLine = [[UIView alloc] init];
    separatorLine.backgroundColor = kRCDefaultLightgray;
    [self.view addSubview:separatorLine];
    _separatorLine = separatorLine;

    NSString *descriptionText = kRCLocalizedString(@"RegisterUploadDescriptionTitle");
    UILabel *msgLabel = [[UILabel alloc] init];
    msgLabel.font = kRCSystemFont(14);
    msgLabel.numberOfLines = 0;
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.text = descriptionText;
    [self.view addSubview:msgLabel];
    _msgLabel = msgLabel;
    
    RCCameraButton *cameraButton = [[RCCameraButton alloc] init];
    cameraButton.adjustsImageWhenHighlighted = NO;
    [cameraButton setImage:kRCImage(@"camera") forState:UIControlStateNormal];
    [cameraButton setBackgroundColor:kRCDefaultBlue];
    [cameraButton addTarget:self action:@selector(cameraDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];
    _cameraButton = cameraButton;
}

- (void)addConstraint {
    [_backGroundImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backGroundImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:64 + 10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backGroundImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCIOSPt(614)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backGroundImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCIOSPt(1028)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backGroundImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [_separatorLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_backGroundImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1]];
    
    [_msgLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_msgLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_separatorLine attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_msgLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_msgLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20]];
    
    [_cameraButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cameraButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_msgLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cameraButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cameraButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cameraButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cameraDidClick {
    UIAlertController *uploadAlertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:kRCLocalizedString(@"RegisterUploadCameraActionTitle") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acquireCamaraGalleryPhoto:) name:kRCCameraGalleryNotification object:nil];
        [[RCCamerGalleryManager shareManager] openCameraAcquirePhotoWithCurrentViewController:self];
    }];
    UIAlertAction *galleryAction = [UIAlertAction actionWithTitle:kRCLocalizedString(@"RegisterUploadGalleryActionTitle") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acquireCamaraGalleryPhoto:) name:kRCCameraGalleryNotification object:nil];
        [[RCCamerGalleryManager shareManager] openGalleryAcquirePhotoWithCurrentViewController:self];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:kRCLocalizedString(@"RegisterUploadCancelActionTitle") style:UIAlertActionStyleCancel handler:nil];
    
    [uploadAlertVc addAction:cameraAction];
    [uploadAlertVc addAction:galleryAction];
    [uploadAlertVc addAction:cancelAction];
    [self presentViewController:uploadAlertVc animated:YES completion:nil];
}

- (void)acquireCamaraGalleryPhoto:(NSNotification *)notice {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    UIImage *selectedPhoto = notice.userInfo[kRCCameraGalleryNotification];
    RCRegisterUploadPhotoViewController *registerUploadVc = [[RCRegisterUploadPhotoViewController alloc] init];
    registerUploadVc.selectedPassPhoto = selectedPhoto;
    [self.navigationController pushViewController:registerUploadVc animated:YES];
}

@end
