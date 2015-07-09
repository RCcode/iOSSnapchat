//
//  RCMainLikeModel.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/18.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeModel.h"
#import "RCUserInfoModel.h"

@implementation RCMainLikeModel

- (void)parse:(id)responseObject {
    _state = responseObject[@"state"];
    _mess = responseObject[@"mess"];
    _type = responseObject[@"type"];

    NSDictionary *userInfoDict = responseObject[@"userinfo"];
    RCUserInfoModel *userInfo = [[RCUserInfoModel alloc] init];
    [userInfo setValuesForKeysWithDictionary:userInfoDict];
    _userinfo = userInfo;
}

@end
