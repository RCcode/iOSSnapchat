//
//  RCMainMatchModel.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/18.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainMatchModel.h"
#import "RCUserInfoModel.h"

@implementation RCMainMatchModel

- (void)parse:(id)responseObject {
    _state = responseObject[@"state"];
    _mess = responseObject[@"mess"];
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
    NSArray *responeUserInfo = responseObject[@"user_info"];
    for (NSDictionary *dict in responeUserInfo) {
        RCUserInfoModel *userInfo = [[RCUserInfoModel alloc] init];
        [userInfo setValuesForKeysWithDictionary:dict];
        [list addObject:userInfo];
    }
    _list = list;
}

@end
