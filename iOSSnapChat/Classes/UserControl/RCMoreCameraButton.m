//
//  RCMoreCameraButton.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/7/3.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMoreCameraButton.h"

#define kRCMoreCameraButtonImageWidth kRCAdaptationWidth(27)
#define kRCMoreCameraButtonImageHeight kRCAdaptationHeight(22)

@implementation RCMoreCameraButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake((self.bounds.size.width - kRCMoreCameraButtonImageWidth) / 2, (self.bounds.size.height - kRCMoreCameraButtonImageHeight) / 2, kRCMoreCameraButtonImageHeight, kRCMoreCameraButtonImageHeight);
}

@end
