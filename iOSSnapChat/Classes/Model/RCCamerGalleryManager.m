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
        selectPhoto = [self imageCompressForWidth:selectPhoto targetWidth:320];
        RCCutPhotoViewController *cutPhotoVc = [[RCCutPhotoViewController alloc] init];
        cutPhotoVc.fromVc = _currentViewController;
        cutPhotoVc.cutImage = selectPhoto;
        [_currentViewController.navigationController pushViewController:cutPhotoVc animated:YES];
    }];
}

- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

@end
