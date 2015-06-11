//
//  RCPlaceHolderAlwaysTextField.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/11.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCPlaceHolderAlwaysTextField.h"

#define kRCPlaceHolderAlwaysTextFieldMargin 10

@implementation RCPlaceHolderAlwaysTextField

- (void)setUserPlaceHolder:(NSString *)userPlaceHolder {
    _userPlaceHolder = userPlaceHolder;
    [self setNeedsDisplay];
}

//控制编辑文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    CGSize size = [_userPlaceHolder boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    return CGRectMake(bounds.origin.x + size.width + kRCPlaceHolderAlwaysTextFieldMargin, bounds.origin.y, bounds.size.width - (bounds.origin.x + size.width + kRCPlaceHolderAlwaysTextFieldMargin), bounds.size.height);
}

//控制显示文本的位置
- (CGRect)textRectForBounds:(CGRect)bounds {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    CGSize size = [_userPlaceHolder boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    return CGRectMake(bounds.origin.x + size.width + kRCPlaceHolderAlwaysTextFieldMargin, bounds.origin.y, bounds.size.width - (bounds.origin.x + size.width + kRCPlaceHolderAlwaysTextFieldMargin), bounds.size.height);
}

- (void)drawRect:(CGRect)rect {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    CGSize size = [_userPlaceHolder boundingRectWithSize:CGSizeMake(rect.size.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    [_userPlaceHolder drawInRect:CGRectMake(0, (rect.size.height - size.height) * 0.5, size.width, size.height) withAttributes:attributes];
}

@end
