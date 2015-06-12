//
//  RCHomePageCell.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/9.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCHomePageCell : UICollectionViewCell

//主页显示文本
@property (nonatomic, copy) NSString *drawTitle;
//主页背景图片
@property (nonatomic, strong) UIImage *drawImage;

- (void)drawTitle:(NSString *)title image:(UIImage *)image;

@end
