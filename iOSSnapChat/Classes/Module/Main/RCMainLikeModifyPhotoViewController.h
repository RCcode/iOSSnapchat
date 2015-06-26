//
//  RCMainLikeModifyPhotoViewController.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/25.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCBaseNormalViewController.h"
@class RCUserInfoModel;

@interface RCMainLikeModifyPhotoViewController : RCBaseNormalViewController

@property (nonatomic, strong) RCUserInfoModel *userInfo;
@property (nonatomic, copy) void (^complete)(UIImage *showImage);

@end
