//
//  RCPikerViewTextFiled.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/11.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCPikerViewTextFiled.h"

//自定义不隐藏占位文本PickerViewTextField隐藏光标参数
#define kRCPikerViewTextFiledHideDistanece 100
//自定义不隐藏占位文本PickerViewTextField间距
#define kRCPikerViewTextFiledMargin 10
//自定义不隐藏占位文本PickerViewTextField文本字体
#warning modify
#define kRCPikerViewTextFiledFont kRCSystemFont(17)

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
    //重绘占位文本
    NSDictionary *placeHolderAttributes = @{NSFontAttributeName: kRCPikerViewTextFiledFont, NSForegroundColorAttributeName: kRCDefaultLightgray};
    CGSize placeHolderSize = [_userPlaceHolder sizeForLineWithSize:CGSizeMake(rect.size.width, MAXFLOAT) Attributes:placeHolderAttributes];
    [_userPlaceHolder drawInRect:CGRectMake(0, (rect.size.height - placeHolderSize.height) * 0.5, placeHolderSize.width, placeHolderSize.height) withAttributes:placeHolderAttributes];
    //重绘输入文本
    NSDictionary *textAttributes = @{NSFontAttributeName: kRCPikerViewTextFiledFont, NSForegroundColorAttributeName: [UIColor blackColor]};
    CGSize textSize = [_userText sizeForLineWithSize:CGSizeMake(rect.size.width, MAXFLOAT) Attributes:textAttributes];
    [_userText drawInRect:CGRectMake(rect.size.width - textSize.width - kRCPikerViewTextFiledMargin, (rect.size.height - textSize.height) * 0.5, textSize.width, textSize.height) withAttributes:textAttributes];
}

@end
