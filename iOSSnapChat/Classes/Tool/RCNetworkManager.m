//
//  RCNetworkManager.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/10.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCNetworkManager.h"

@implementation RCNetworkManager

static id _manager;
static id _instance;

#pragma mark - 单例
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //AFN单例
        NSURLSessionConfiguration *confi = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:confi];
        sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        sessionManager.responseSerializer.acceptableContentTypes = [sessionManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        sessionManager.requestSerializer.HTTPShouldHandleCookies = YES;
        _manager = sessionManager;
        //网络单例
        RCNetworkManager *instance = [[self alloc] init];
        _instance = instance;
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copy {
    return _instance;
}

#pragma mark - Utility
- (void)GETRequest:(NSString *)urlString parameters:(id)parameters success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [_manager GET:urlString parameters:parameters success:success failure:failure];
}

- (void)POSTRequest:(NSString *)urlString parameters:(id)parameters success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [_manager POST:urlString parameters:parameters success:success failure:failure];
}

- (void)POSTRequest:(NSString *)urlString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [_manager POST:urlString parameters:parameters constructingBodyWithBlock:block success:success failure:failure];
}

@end
