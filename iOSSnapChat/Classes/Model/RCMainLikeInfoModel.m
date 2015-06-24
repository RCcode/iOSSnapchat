//
//  RCMainLikeInfoModel.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/24.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeInfoModel.h"

@implementation RCMainLikeInfoModel

- (void)parse:(id)responseObject {
    [self setValuesForKeysWithDictionary:responseObject];
}

@end
