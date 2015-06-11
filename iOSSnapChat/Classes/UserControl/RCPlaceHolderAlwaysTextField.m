//
//  RCPlaceHolderAlwaysTextField.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/11.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCPlaceHolderAlwaysTextField.h"

#define kRCPlaceHolderAlwaysTextFieldMargin 10
#define kRCPlaceHolderAlwaysTextFieldFont kRCSystemFont(17)

@implementation RCPlaceHolderAlwaysTextField

- (void)setUserPlaceHolder:(NSString *)userPlaceHolder {
    _userPlaceHolder = userPlaceHolder;
    [self setNeedsDisplay];
}

//编辑文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self editAndTextRect:bounds];
}

//显示文本的位置
- (CGRect)textRectForBounds:(CGRect)bounds {
    return [self editAndTextRect:bounds];
}

- (void)drawRect:(CGRect)rect {
    NSDictionary *attributes = @{NSFontAttributeName: kRCPlaceHolderAlwaysTextFieldFont, NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    CGSize placeHolderSize = [_userPlaceHolder sizeForLineWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) Attributes:attributes];
    [_userPlaceHolder drawInRect:CGRectMake(0, (rect.size.height - placeHolderSize.height) * 0.5, placeHolderSize.width, placeHolderSize.height) withAttributes:attributes];
}

#pragma mark - Utility
//获取编辑/显示文本Rect
- (CGRect)editAndTextRect:(CGRect)bounds {
    NSDictionary *attributes = @{NSFontAttributeName: kRCPlaceHolderAlwaysTextFieldFont};
    CGSize placeHolderSize = [_userPlaceHolder sizeForLineWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) Attributes:attributes];
    return CGRectMake(bounds.origin.x + placeHolderSize.width + kRCPlaceHolderAlwaysTextFieldMargin, bounds.origin.y, bounds.size.width - (bounds.origin.x + placeHolderSize.width + kRCPlaceHolderAlwaysTextFieldMargin), bounds.size.height);
}


@end
