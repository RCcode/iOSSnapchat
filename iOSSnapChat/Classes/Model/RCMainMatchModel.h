//
//  RCMainMatchModel.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/18.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCModelBase.h"

@interface RCMainMatchModel : RCModelBase

//状态码
@property (nonatomic, strong) NSNumber *state;
//状态说明
@property (nonatomic, copy) NSString *mess;
//List
@property (nonatomic, strong) NSMutableArray *list;

@end
