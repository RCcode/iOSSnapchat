//
//  RCHitTestEventThroughImageView.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/7/2.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCHitTestEventThroughImageView.h"

@implementation RCHitTestEventThroughImageView

- (id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self)
    {
        return nil;
    }
    else
    {
        return hitView;
    }
}

@end
