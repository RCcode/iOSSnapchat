//
//  RCModelBase.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/10.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCModelBase.h"

@implementation RCModelBase

- (void)requestServerWithModel:(id)requestModel success:(void(^)(id resultModel))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    RCNetworkManager *manager = [RCNetworkManager shareManager];
    if (_modelRequestMethod == kRCModelRequestMethodTypeGET) {
        [manager GETRequest:_requestUrl parameters:_parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self parse:responseObject];
            success(self);
        } failure:failure];
    } else if (_modelRequestMethod == kRCModelRequestMethodTypePOST) {
        [manager POSTRequest:_requestUrl parameters:_parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self parse:responseObject];
            success(self);
        } failure:failure];
    }
}

- (void)parse:(id)responseObject {}

@end
