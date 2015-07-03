//
//  RCPhotoView.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/19.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCMoreCameraButton;

@interface RCPhotoView : UIView

@property (nonatomic, strong) NSURL *photoURL;
@property (nonatomic, weak) RCMoreCameraButton *camaraButton;
@property (nonatomic, weak) UIImageView *photoImageView;

@end
