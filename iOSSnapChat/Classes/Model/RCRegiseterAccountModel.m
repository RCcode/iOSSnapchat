//
//  RCRegiseterAccountModel.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/10.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegiseterAccountModel.h"

@implementation RCRegiseterAccountModel

- (void)parse:(id)responseObject {
    [self setValuesForKeysWithDictionary:responseObject];
}

@end
