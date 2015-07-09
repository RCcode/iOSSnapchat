//
//  RCRegisterUploadViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/11.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegisterUploadViewController.h"
#import "RCRegisterUploadPhotoViewController.h"

//主界面约束
#define kRCRegisterInfoTopBackgroudViewTopConstant 0
#define kRCRegisterInfoTopBackgroudViewLeftConstant 0
#define kRCRegisterInfoTopBackgroudViewRightConstant 0
#define kRCRegisterInfoTopBackgroudViewHeightConstant (kRCAdaptationHeight(42) + 64 + kRCAdaptationHeight(610))

#define kRCRegisterInfoBottomBackgroudViewTopConstant 0
#define kRCRegisterInfoBottomBackgroudViewBottomConstant 0
#define kRCRegisterInfoBottomBackgroudViewLeftConstant 0
#define kRCRegisterInfoBottomBackgroudViewRightConstant 0

#define kRCRegisterInfoBackGroundImageViewTopConstant (kRCAdaptationHeight(42) + 64)
#define kRCRegisterInfoBackGroundImageViewWidthConstant kRCAdaptationWidth(364)
#define kRCRegisterInfoBackGroundImageViewHeightConstant kRCAdaptationHeight(610)

#define kRCRegisterInfoSeparatorLineTopConstant 0
#define kRCRegisterInfoSeparatorLineLeftConstant 0
#define kRCRegisterInfoSeparatorLineRightConstant 0
#define kRCRegisterInfoSeparatorLineHeightConstant 1

#define kRCRegisterInfoMsgLabelTopConstant kRCAdaptationHeight(56)
#define kRCRegisterInfoMsgLabelLeftConstant kRCAdaptationWidth(34)
#define kRCRegisterInfoMsgLabelRightConstant kRCAdaptationWidth(34)

#define kRCRegisterInfoCameraButtonBottomConstant kRCAdaptationHeight(56)
#define kRCRegisterInfoCameraButtonLeftConstant kRCAdaptationWidth(34)
#define kRCRegisterInfoCameraButtonRightConstant kRCAdaptationWidth(34)
#define kRCRegisterInfoCameraButtonHeightConstant kRCAdaptationHeight(78)

@interface RCRegisterUploadViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    //MainUI
    UIView *_topBackgroudView;
    UIView *_bottomBackgroudView;
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
    UIView *topBackgroudView = [[UIView alloc] init];
    topBackgroudView.backgroundColor = kRCDefaultBackWhiteColor;
    [self.view addSubview:topBackgroudView];
    _topBackgroudView = topBackgroudView;

    UIView *bottomBackgroudView = [[UIView alloc] init];
    bottomBackgroudView.backgroundColor = kRCDefaultWhite;
    [self.view addSubview:bottomBackgroudView];
    _bottomBackgroudView = bottomBackgroudView;
    
    UIImageView *backGroundImageView = [[UIImageView alloc] init];
    backGroundImageView.image = kRCImage(@"shili");
    [self.view addSubview:backGroundImageView];
    _backGroundImageView = backGroundImageView;
    
    UIView *separatorLine = [[UIView alloc] init];
    separatorLine.backgroundColor = kRCSystemLightgray;
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
    [_topBackgroudView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_topBackgroudView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCRegisterInfoTopBackgroudViewTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_topBackgroudView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCRegisterInfoTopBackgroudViewLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_topBackgroudView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCRegisterInfoTopBackgroudViewRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_topBackgroudView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoTopBackgroudViewHeightConstant]];
    
    [_bottomBackgroudView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bottomBackgroudView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_topBackgroudView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCRegisterInfoBottomBackgroudViewTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bottomBackgroudView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCRegisterInfoBottomBackgroudViewBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bottomBackgroudView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCRegisterInfoBottomBackgroudViewLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_bottomBackgroudView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCRegisterInfoBottomBackgroudViewRightConstant]];

    [_backGroundImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backGroundImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCRegisterInfoBackGroundImageViewTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backGroundImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoBackGroundImageViewWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backGroundImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoBackGroundImageViewHeightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backGroundImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [_separatorLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_backGroundImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCRegisterInfoSeparatorLineTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCRegisterInfoSeparatorLineLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCRegisterInfoSeparatorLineRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoSeparatorLineHeightConstant]];
    
    [_msgLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_msgLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_separatorLine attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCRegisterInfoMsgLabelTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_msgLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCRegisterInfoMsgLabelLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_msgLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCRegisterInfoMsgLabelRightConstant]];
    
    [_cameraButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cameraButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCRegisterInfoCameraButtonBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cameraButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCRegisterInfoCameraButtonLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cameraButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCRegisterInfoCameraButtonRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cameraButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoCameraButtonHeightConstant]];
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
