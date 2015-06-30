//
//  RCUnderLineButton.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/29.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCUnderLineButton.h"

@implementation RCUnderLineButton

+ (RCUnderLineButton *)underlinedButton {
    RCUnderLineButton *button = [[RCUnderLineButton alloc] init];
    return button;
}

- (void)drawRect:(CGRect)rect {
    CGRect textRect = self.titleLabel.frame;
    CGFloat descender = self.titleLabel.font.descender;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender);
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender);
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}

@end
