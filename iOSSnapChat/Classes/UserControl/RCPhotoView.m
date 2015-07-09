//
//  RCPhotoView.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/19.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCPhotoView.h"

@interface RCPhotoView ()

@end

@implementation RCPhotoView


#pragma mark - Setter
- (void)setPhotoURL:(NSURL *)photoURL {
    _photoURL = photoURL;
    [_photoImageView sd_setImageWithURL:photoURL placeholderImage:kRCImage(@"people_bg")];
}

#pragma mark - LifeCircle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *photoImageView = [[UIImageView alloc] init];
        [self addSubview:photoImageView];
        _photoImageView = photoImageView;
        
        RCMoreCameraButton *camaraButton = [[RCMoreCameraButton alloc] init];
        [camaraButton setImage:kRCImage(@"more_camera_icon") forState:UIControlStateNormal];
        [self addSubview:camaraButton];
        camaraButton.backgroundColor = kRCDefaultAlphaBlack;
        _camaraButton = camaraButton;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat side = 0;
    if (self.frame.size.height >= self.frame.size.width) {
        side = self.frame.size.width;
    } else {
        side = self.frame.size.height;
    }
    
    _photoImageView.frame = CGRectMake(0, 0, side, side);
    _camaraButton.frame = CGRectMake(0, side - kRCAdaptationHeight(40), side, kRCAdaptationHeight(40));
    
    self.layer.cornerRadius = side / 2;
    self.layer.masksToBounds = YES;
}

@end
