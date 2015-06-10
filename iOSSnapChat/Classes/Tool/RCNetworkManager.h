//
//  RCNetworkManager.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/10.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCNetworkManager : NSObject

+ (instancetype)shareManager;

//GET请求
- (void)GETRequest:(NSString *)urlString parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;
//POST请求
- (void)POSTRequest:(NSString *)urlString parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;
//POST上传图片
- (void)POSTRequest:(NSString *)urlString parameters:(id)parameters upateFileData:(NSData *)fileData success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
