//
//  RCLoginNormalModel.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/15.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCLoginNormalModel.h"


@implementation RCLoginUserInfo

@end

@implementation RCLoginNormalModel

- (void)parse:(id)responseObject {
    _state = responseObject[@"state"];
    _mess = responseObject[@"mess"];
    _usertoken = responseObject[@"usertoken"];
    NSDictionary *userInfoDict = responseObject[@"user_info"];
    RCLoginUserInfo *userInfo = [[RCLoginUserInfo alloc] init];
    [userInfo setValuesForKeysWithDictionary:userInfoDict];
    _userInfo = userInfo;
}

@end
