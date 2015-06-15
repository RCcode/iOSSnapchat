//
//  RCLoginNormalModel.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/15.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCLoginNormalModel.h"

@implementation RCLoginNormalModel

- (void)parse:(id)responseObject {
    _state = responseObject[@"state"];
    _mess = responseObject[@"mess"];
    _usertoken = responseObject[@"usertoken"];
}

@end
