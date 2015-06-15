//
//  RCRegiseterInfoModel.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/15.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCModelBase.h"

@interface RCRegiseterInfoModel : RCModelBase

//状态码
@property (nonatomic, assign) NSInteger state;
//状态说明
@property (nonatomic, copy) NSString *mess;
//注册步骤
@property (nonatomic, copy) NSString *step;

@end
