//
//  RCMainLikePhotoDetailViewController.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/24.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCBaseArrowViewController.h"
#import "RCUserInfoModel.h"

typedef NS_ENUM(NSInteger, kRCMainLikeType) {
    kRCMainLikeTypeUnlike = 0,
    kRCMainLikeTypeLike
};

typedef struct {
    float longitude;
    float latitude;
}RCLocation;

@interface RCMainLikePhotoDetailViewController : RCBaseArrowViewController

//选中的详情item
@property (nonatomic, assign) NSInteger selectedItem;
//选中的用户资料
@property (nonatomic, strong) RCUserInfoModel *selectedUserInfo;
//执行Like/UnLike的回调Block
@property (nonatomic, copy) void (^complete)(kRCMainLikeType type);

@end
