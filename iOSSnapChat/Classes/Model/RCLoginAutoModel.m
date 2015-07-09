//
//  RCLoginAutoModel.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/17.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCLoginAutoModel.h"
#import "RCUserInfoModel.h"

@implementation RCLoginAutoModel

- (void)parse:(id)responseObject {
    _state = responseObject[@"state"];
    _mess = responseObject[@"mess"];
    NSDictionary *userInfoDict = responseObject[@"user_info"];
    RCUserInfoModel *userInfo = [[RCUserInfoModel alloc] init];
    [userInfo setValuesForKeysWithDictionary:userInfoDict];
    _userInfo = userInfo;
}

@end
