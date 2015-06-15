//
//  RCLocalTool.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/15.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCLocalTool : NSObject

//获取本地地址(获取完成之前需要保证此对象不销毁)
- (void)acquireLocation;

@end
