//
//  RCHomePageCell.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/9.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCHomePageCell.h"

#define kHomePageTitleFont kRCSystemFont(17)

@implementation RCHomePageCell

- (void)drawTitle:(NSString *)title image:(UIImage *)image {
    _drawTitle = title;
    _drawImage = image;
    //重绘内容
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    //重绘背景
    [_drawImage drawInRect:rect];
    //重绘文字
    NSDictionary *attributes = @{NSFontAttributeName: kHomePageTitleFont, NSForegroundColorAttributeName: [UIColor blackColor]};
    CGSize titleSize = [_drawTitle boundingRectWithSize:CGSizeMake(kRCScreenWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:NULL].size;
    [_drawTitle drawInRect:CGRectMake((kRCScreenWidth - titleSize.width) * 0.5, (kRCScreenHeight - titleSize.height) * 0.25, titleSize.width, titleSize.height) withAttributes:attributes];
}

@end
