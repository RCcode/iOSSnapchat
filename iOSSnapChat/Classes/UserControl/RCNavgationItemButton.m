//
//  RCNavgationItemButton.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/7/2.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCNavgationItemButton.h"

#define kRCNavgationItemButtonImageWidth kRCAdaptationWidth(50)
#define kRCNavgationItemButtonImageHeight kRCAdaptationHeight(50)

@implementation RCNavgationItemButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake((self.bounds.size.width - kRCNavgationItemButtonImageWidth) / 2, (self.bounds.size.height - kRCNavgationItemButtonImageHeight) / 2, kRCNavgationItemButtonImageWidth, kRCNavgationItemButtonImageHeight);
}

@end
