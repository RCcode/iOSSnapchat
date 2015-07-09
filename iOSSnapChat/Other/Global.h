//
//  Global.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/7/7.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject

+ (instancetype)shareGlobal;

@property (nonatomic, copy) NSString *registerAccountURLString;
@property (nonatomic, copy) NSString *registerInfoURLString;
@property (nonatomic, copy) NSString *registerUploadPhotoURLString;

@property (nonatomic, copy) NSString *loginnormalLoginURLString;
@property (nonatomic, copy) NSString *loginAutoLoginURLString;
@property (nonatomic, copy) NSString *forgetPasswordURLString;

@property (nonatomic, copy) NSString *mainLikeLoadingListURLString;
@property (nonatomic, copy) NSString *mainLikeLikeUnLikeURLString;
@property (nonatomic, copy) NSString *mainLikeModifySnapchatURLString;
@property (nonatomic, copy) NSString *mainLikeInformURLString;
@property (nonatomic, copy) NSString *mainLikeMessageListURLString;

@end
