//
//  RCMainLikeCollectionViewCell.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/18.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeCollectionViewCell.h"

@interface RCMainLikeCollectionViewCell ()
{
    UIImageView *_showImageView;
}

@end

@implementation RCMainLikeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *showImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:showImageView];
        _showImageView = showImageView;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *showImageView = [[UIImageView alloc] init];
    self.backgroundView = showImageView;
    _showImageView = showImageView;
}

- (void)setShowImageURL:(NSURL *)showImageURL {
    _showImageURL = showImageURL;
    [_showImageView sd_setImageWithURL:showImageURL placeholderImage:[UIImage imageNamed:@"default.jpg"]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _showImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
}

@end
