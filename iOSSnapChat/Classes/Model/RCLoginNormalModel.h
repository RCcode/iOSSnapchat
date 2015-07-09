//
//  RCLoginNormalModel.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/15.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCModelBase.h"
@class RCUserInfoModel;

@interface RCLoginNormalModel : RCModelBase

//状态码
@property (nonatomic, strong) NSNumber *state;
//状态说明
@property (nonatomic, copy) NSString *mess;
//usertoken
@property (nonatomic, copy) NSString *usertoken;
//userInfo
@property (nonatomic, strong) RCUserInfoModel *userInfo;

@end
