//
//  Global.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/7/7.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "Global.h"

@implementation Global

static id _instance;
+ (instancetype)shareGlobal {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
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

#ifndef Test
#define Test 1
#endif

- (NSString *)registerAccountURLString {
#if Test
    return @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/Regi1.do";
#else
    return @"http://snapchat.rcplatformhk.com/ExcavateSnapchatWeb/userinfo/Regi1.do";
#endif
}

- (NSString *)registerInfoURLString {
#if Test
    return @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/Regi2.do";
#else
    return @"http://snapchat.rcplatformhk.com/ExcavateSnapchatWeb/userinfo/Regi2.do";
#endif
}

- (NSString *)registerUploadPhotoURLString {
#if Test
    return @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/Regi3.do?method=upload";
#else
    return @"http://snapchat.rcplatformhk.com/ExcavateSnapchatWeb/userinfo/Regi3.do?method=upload";
#endif
}

- (NSString *)loginnormalLoginURLString {
#if Test
    return @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/Login.do";
#else
    return @"http://snapchat.rcplatformhk.com/ExcavateSnapchatWeb/userinfo/Login.do";
#endif
}

- (NSString *)loginAutoLoginURLString {
#if Test
    return @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/AutoLogin.do";
#else
    return @"http://snapchat.rcplatformhk.com/ExcavateSnapchatWeb/userinfo/AutoLogin.do";
#endif
}

- (NSString *)forgetPasswordURLString {
#if Test
    return @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/SendEmail.do";
#else
    return @"http://snapchat.rcplatformhk.com/ExcavateSnapchatWeb/userinfo/SendEmail.do";
#endif
}

- (NSString *)mainLikeLoadingListURLString {
#if Test
    return @"http://192.168.0.88:8088/ExcavateSnapchatWeb/excavate/ExcavateUser.do";
#else
    return @"http://snapchat.rcplatformhk.com/ExcavateSnapchatWeb/excavate/ExcavateUser.do";
#endif
}

- (NSString *)mainLikeLikeUnLikeURLString {
#if Test
    return @"http://192.168.0.88:8088/ExcavateSnapchatWeb/message/LikeUser.do";
#else
    return @"http://snapchat.rcplatformhk.com/ExcavateSnapchatWeb/message/LikeUser.do";
#endif
}

- (NSString *)mainLikeModifySnapchatURLString {
#if Test
    return @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/ChangeSnapchat.do";
#else
    return @"http://snapchat.rcplatformhk.com/ExcavateSnapchatWeb/userinfo/ChangeSnapchat.do";
#endif
}

- (NSString *)mainLikeInformURLString {
#if Test
    return @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/ReportUsers.do";
#else
    return @"http://snapchat.rcplatformhk.com/ExcavateSnapchatWeb/userinfo/ReportUsers.do";
#endif
}

- (NSString *)mainLikeMessageListURLString {
#if Test
    return @"http://192.168.0.88:8088/ExcavateSnapchatWeb/message/getLikeUser.do";
#else
    return @"http://snapchat.rcplatformhk.com/ExcavateSnapchatWeb/message/getLikeUser.do";
#endif
}



@end
