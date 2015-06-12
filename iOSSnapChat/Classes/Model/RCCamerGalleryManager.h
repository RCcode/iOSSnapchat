//
//  RCCamerGalleryManager.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/12.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCCamerGalleryManager : UIImagePickerController

//通过通知中心获取相册或者相机的图片
//通知键值kRCCameraGalleryNotification

+ (instancetype)shareManager;
//打开相册获取图片(需传入当前控制器) 通知中心获取图片后需立即在回调方法中注销通知，否则可能导致多次接收通知
- (void)openGalleryAcquirePhotoWithCurrentViewController:(UIViewController *)currentViewController;
//打开相机获取图片(需传入当前控制器) 通知中心获取图片后需立即在回调方法中注销通知，否则可能导致多次接收通知
- (void)openCameraAcquirePhotoWithCurrentViewController:(UIViewController *)currentViewController;

@end
