//
//  RCNetworkManager.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/10.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface RCNetworkManager : NSObject

+ (instancetype)shareManager;

//GET
- (void)GETRequest:(NSString *)urlString parameters:(id)parameters success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//POST
- (void)POSTRequest:(NSString *)urlString parameters:(id)parameters success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//POST图片
- (void)POSTRequest:(NSString *)urlString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
