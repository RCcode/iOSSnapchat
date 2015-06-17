//
//  RCLoginNormalModel.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/15.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCModelBase.h"


@interface RCLoginUserInfo : NSObject

@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *iospushtoken;
@property (nonatomic, copy) NSString *countryid;
@property (nonatomic, copy) NSString *cityid;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *snapchatid;
@property (nonatomic, copy) NSString *lon;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *url1;
@property (nonatomic, copy) NSString *url2;
@property (nonatomic, copy) NSString *url3;

//未启用字段
@property (nonatomic, copy) NSString *gender2;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *usertoken;
@property (nonatomic, copy) NSString *pushtoken;
@property (nonatomic, copy) NSString *status;

@end


@interface RCLoginNormalModel : RCModelBase

//状态码
@property (nonatomic, assign) NSInteger state;
//状态说明
@property (nonatomic, copy) NSString *mess;
//usertoken
@property (nonatomic, copy) NSString *usertoken;
//info
@property (nonatomic, strong) RCLoginUserInfo *userInfo;

@end
