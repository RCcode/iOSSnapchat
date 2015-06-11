//
//  NSString+RCStringSize.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/11.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RCStringSize)

- (CGSize)sizeForLineWithSize:(CGSize)size Attributes:(NSDictionary *)attributes;

@end
