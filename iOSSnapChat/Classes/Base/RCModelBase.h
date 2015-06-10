//
//  RCModelBase.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/10.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, kRCModelRequestMethodType) {
    kRCModelRequestMethodTypeGET = 1,
    kRCModelRequestMethodTypePOST
};

@interface RCModelBase : NSObject

//请求参数
@property (nonatomic, assign) kRCModelRequestMethodType modelRequestMethod;
@property (nonatomic, copy) NSString *requestUrl;
@property (nonatomic, strong) NSDictionary *parameters;

//请求方法


- (void)requestServerWithModel:(id)requestModel success:(void(^)(id resultModel))success failure:(void (^)(NSError *error))failure;
- (void)parse:(id)responseObject;

@end
