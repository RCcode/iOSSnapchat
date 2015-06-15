//
//  RCMBHUDTool.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/15.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCMBHUDTool : NSObject

//显示文本
+ (void)showText:(NSString *)text hideDelay:(NSTimeInterval)second;
//加载指示器
+ (void)showIndicator;
+ (void)hideshowIndicator;

@end
