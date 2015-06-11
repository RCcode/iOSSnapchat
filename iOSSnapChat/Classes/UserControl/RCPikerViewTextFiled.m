//
//  RCPikerViewTextFiled.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/11.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCPikerViewTextFiled.h"

#define kRCPikerViewTextFiledHideDistanece 100
#define kRCPikerViewTextFiledMargin 10

@implementation RCPikerViewTextFiled

- (void)setUserPlaceHolder:(NSString *)userPlaceHolder {
    _userPlaceHolder = userPlaceHolder;
    [self setNeedsDisplay];
}

- (void)setUserText:(NSString *)userText {
    _userText = userText;
    [self setNeedsDisplay];
}

//控制编辑文本的位置(隐藏光标)
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x, bounds.origin.y + kRCPikerViewTextFiledHideDistanece, bounds.size.width, bounds.size.height);
}

- (void)drawRect:(CGRect)rect {
    NSDictionary *placeHolderAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    CGSize placeHolderSize = [_userPlaceHolder boundingRectWithSize:CGSizeMake(rect.size.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:placeHolderAttributes context:nil].size;
    [_userPlaceHolder drawInRect:CGRectMake(0, (rect.size.height - placeHolderSize.height) * 0.5, placeHolderSize.width, placeHolderSize.height) withAttributes:placeHolderAttributes];
    
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName: [UIColor blackColor]};
    CGSize textSize = [_userText boundingRectWithSize:CGSizeMake(rect.size.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:textAttributes context:nil].size;
    [_userText drawInRect:CGRectMake(placeHolderSize.width + kRCPikerViewTextFiledMargin, (rect.size.height - textSize.height) * 0.5, textSize.width, textSize.height) withAttributes:textAttributes];
}

@end
