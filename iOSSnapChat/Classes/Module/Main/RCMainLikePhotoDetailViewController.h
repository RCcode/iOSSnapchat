//
//  RCMainLikePhotoDetailViewController.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/24.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCBaseArrowViewController.h"
#import "RCUserInfoModel.h"

@interface RCMainLikePhotoDetailViewController : RCBaseArrowViewController

//选中的详情item
@property (nonatomic, assign) NSInteger selectedItem;
//选中的用户资料
@property (nonatomic, strong) RCUserInfoModel *selectedUserInfo;

@end
