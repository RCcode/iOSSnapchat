//
//  RCRegiseterAccountModel.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/10.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCModelBase.h"

@interface RCRegiseterAccountModel : RCModelBase

//状态码
@property (nonatomic, strong) NSNumber *state;
//状态说明
@property (nonatomic, copy) NSString *mess;
//用户自动登录usertoken
@property (nonatomic, copy) NSString *usertoken;
//注册步骤
@property (nonatomic, strong) NSNumber *step;

@end
