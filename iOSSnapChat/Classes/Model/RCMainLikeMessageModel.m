//
//  RCMainLikeMessageModel.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/24.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeMessageModel.h"
#import "RCMainMessageUserInfoModel.h"
#import "RCUserInfoModel.h"

@implementation RCMainLikeMessageModel

- (void)parse:(id)responseObject {
    NSDictionary *responseDict = (NSDictionary *)responseObject;
    _mess = responseDict[@"mess"];
    _state = responseDict[@"state"];
    
    NSArray *user_infoArray = (NSArray *)responseObject[@"user_info"];
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dict in user_infoArray) {
        RCMainMessageUserInfoModel *mainMessageUserInfo = [[RCMainMessageUserInfoModel alloc] init];
        mainMessageUserInfo.date_time = dict[@"date_time"];
        mainMessageUserInfo.flag = dict[@"flag"];
        mainMessageUserInfo.userid1 = dict[@"userid1"];
        mainMessageUserInfo.userid2 = dict[@"userid2"];
        
        NSDictionary *userInfoDict = dict[@"userinfo"];
        RCUserInfoModel *userInfoModel = [[RCUserInfoModel alloc] init];
        userInfoModel.age = userInfoDict[@"age"];
        userInfoModel.cityid = userInfoDict[@"cityid"];
        userInfoModel.countryid = userInfoDict[@"countryid"];
        userInfoModel.flag = userInfoDict[@"flag"];
        userInfoModel.gender = userInfoDict[@"gender"];
        userInfoModel.gender2 = userInfoDict[@"gender2"];
        userInfoModel.iospushtoken = userInfoDict[@"iospushtoken"];
        userInfoModel.lat = userInfoDict[@"lat"];
        userInfoModel.lon = userInfoDict[@"lon"];
        userInfoModel.password = userInfoDict[@"password"];
        userInfoModel.pushtoken = userInfoDict[@"pushtoken"];
        userInfoModel.snapchatid = userInfoDict[@"snapchatid"];
        userInfoModel.status = userInfoDict[@"status"];
        userInfoModel.url1 = userInfoDict[@"url1"];
        userInfoModel.url2 = userInfoDict[@"url2"];
        userInfoModel.url3 = userInfoDict[@"url3"];
        userInfoModel.userid = userInfoDict[@"userid"];
        userInfoModel.usertoken = userInfoDict[@"usertoken"];
        
        mainMessageUserInfo.userinfo = userInfoModel;
        [list addObject:mainMessageUserInfo];
    }
    _list = list;
}

@end
