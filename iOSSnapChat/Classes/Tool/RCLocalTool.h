//
//  RCLocalTool.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/15.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCLocalTool : NSObject

+ (instancetype)shareManager;

- (void)acquireLocation;

@end
