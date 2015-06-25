//
//  RCUserInfoModel.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/17.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCModelBase.h"

@interface RCUserInfoModel : RCModelBase

@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *iospushtoken;
@property (nonatomic, copy) NSString *countryid;
@property (nonatomic, copy) NSString *cityid;
@property (nonatomic, strong) NSNumber *gender;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, copy) NSString *snapchatid;
@property (nonatomic, strong) NSNumber *lon;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, copy) NSString *url1;
@property (nonatomic, copy) NSString *url2;
@property (nonatomic, copy) NSString *url3;

//message字段
@property (nonatomic, copy) NSString *gender2;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *usertoken;
@property (nonatomic, copy) NSString *pushtoken;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) NSNumber *flag;

@end
