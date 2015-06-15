//
//  RCRegiseterInfoModel.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/15.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegiseterInfoModel.h"

@implementation RCRegiseterInfoModel

- (void)parse:(id)responseObject {
    [self setValuesForKeysWithDictionary:responseObject];
}

@end
