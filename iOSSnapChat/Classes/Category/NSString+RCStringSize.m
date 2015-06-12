//
//  NSString+RCStringSize.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/11.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "NSString+RCStringSize.h"

@implementation NSString (RCStringSize)

- (CGSize)sizeForLineWithSize:(CGSize)size Attributes:(NSDictionary *)attributes {
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}

@end
