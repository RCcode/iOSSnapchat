//
//  RCCamerGalleryManager.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/12.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCCamerGalleryManager.h"
#import "RCCutPhotoViewController.h"

@interface RCCamerGalleryManager () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIViewController *_currentViewController;
}

@end

@implementation RCCamerGalleryManager

static id _instance;

#pragma mark - 单例
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        RCCamerGalleryManager *instance = [[self alloc] init];
        _instance = instance;
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copy {
    return _instance;
}

#pragma mark - Utility
- (void)openGalleryAcquirePhotoWithCurrentViewController:(UIViewController *)currentViewController {
    _currentViewController = currentViewController;
    UIImagePickerController *instance = (UIImagePickerController *)_instance;
    instance.delegate = self;
    instance.allowsEditing = YES;
    [instance setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [currentViewController presentViewController:instance animated:YES completion:nil];
}

- (void)openCameraAcquirePhotoWithCurrentViewController:(UIViewController *)currentViewController {
    _currentViewController = currentViewController;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *instance = (UIImagePickerController *)_instance;
        instance.delegate = self;
        instance.allowsEditing = YES;
        instance.sourceType = UIImagePickerControllerSourceTypeCamera;
        currentViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [currentViewController presentViewController:instance animated:YES completion:nil];
    } else {
        NSLog(@"不能打开相机");
        return;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [_currentViewController dismissViewControllerAnimated:YES completion:^{
        UIImage *selectPhoto = info[UIImagePickerControllerOriginalImage];
        RCCutPhotoViewController *cutPhotoVc = [[RCCutPhotoViewController alloc] init];
        cutPhotoVc.fromVc = _currentViewController;
        cutPhotoVc.cutImage = selectPhoto;
        [_currentViewController.navigationController pushViewController:cutPhotoVc animated:YES];
    }];
}

@end
