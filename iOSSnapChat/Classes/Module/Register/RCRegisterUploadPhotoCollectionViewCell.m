//
//  RCRegisterUploadPhotoCollectionViewCell.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/12.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegisterUploadPhotoCollectionViewCell.h"

#define kRCRegisterUploadPhotoCellImageViewTopConstant 0
#define kRCRegisterUploadPhotoCellImageViewBottomConstant 0
#define kRCRegisterUploadPhotoCellImageViewLeftConstant 0
#define kRCRegisterUploadPhotoCellImageViewRightConstant 0

@interface RCRegisterUploadPhotoCollectionViewCell ()
{
    UIImageView *_imageView;
}

@end

@implementation RCRegisterUploadPhotoCollectionViewCell

- (void)setDrawImage:(UIImage *)drawImage {
    _drawImage = drawImage;
    _imageView.image = drawImage;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        _imageView = imageView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCRegisterUploadPhotoCellImageViewTopConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCRegisterUploadPhotoCellImageViewBottomConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:kRCRegisterUploadPhotoCellImageViewLeftConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCRegisterUploadPhotoCellImageViewRightConstant]];
}

@end
