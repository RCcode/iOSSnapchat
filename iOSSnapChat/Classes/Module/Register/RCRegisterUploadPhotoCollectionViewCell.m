//
//  RCRegisterUploadPhotoCollectionViewCell.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/12.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegisterUploadPhotoCollectionViewCell.h"

@implementation RCRegisterUploadPhotoCollectionViewCell

- (void)setDrawImage:(UIImage *)drawImage {
    _drawImage = drawImage;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
#warning 需要根据图片长宽比计算图片缩放
    //绘制背景
    [_drawImage drawInRect:rect];
}

@end
