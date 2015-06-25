//
//  RCMainMessageUserInfoModel.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/25.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCUserInfoModel;

@interface RCMainMessageUserInfoModel : NSObject

@property (nonatomic, copy) NSString *date_time;
@property (nonatomic, assign) NSNumber *flag;
@property (nonatomic, copy) NSString *userid1;
@property (nonatomic, copy) NSString *userid2;
@property (nonatomic, strong) RCUserInfoModel *userinfo;

@end
