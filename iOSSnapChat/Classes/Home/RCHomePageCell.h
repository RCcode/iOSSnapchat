//
//  RCHomePageCell.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/9.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCHomePageCell : UICollectionViewCell

@property (nonatomic, copy) NSString *drawTitle;
@property (nonatomic, strong) UIImage *drawImage;

- (void)drawTitle:(NSString *)title image:(UIImage *)image;

@end
