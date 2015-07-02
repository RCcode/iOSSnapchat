//
//  RCCameraButton.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/30.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCCameraButton.h"

#define kRCCameraButtonImageWidth kRCAdaptationWidth(55)
#define kRCCameraButtonImageHeight kRCAdaptationHeight(42)

@implementation RCCameraButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake((self.bounds.size.width - kRCCameraButtonImageWidth) / 2, (self.bounds.size.height - kRCCameraButtonImageHeight) / 2, kRCCameraButtonImageWidth, kRCCameraButtonImageHeight);
}

@end
