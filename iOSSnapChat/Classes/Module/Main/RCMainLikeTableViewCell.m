//
//  RCMainLikeTableViewCell.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/19.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeTableViewCell.h"

@interface RCMainLikeTableViewCell ()
{
    UIImageView *_showImageView;
    UILabel *_showLabel;
    UILabel *_moreLabel;
}

@end

@implementation RCMainLikeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *showImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:showImageView];
        _showImageView = showImageView;
        
        UILabel *showLabel = [[UILabel alloc] init];
        [self.contentView addSubview:showLabel];
        _showLabel = showLabel;
        
        UILabel *moreLabel = [[UILabel alloc] init];
        [self.contentView addSubview:moreLabel];
        _moreLabel = moreLabel;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _showImageView.frame = CGRectMake(5, 5, self.frame.size.height - 10, self.frame.size.height - 10);
    _showLabel.frame = CGRectMake(CGRectGetMaxX(_showImageView.frame) + 5, 5, 200, self.frame.size.height - 10);
    _moreLabel.frame = CGRectMake(self.frame.size.width - 5 - 100, 5, 100, self.frame.size.height - 10);
}

- (void)setShowIcon:(UIImage *)showIcon {
    _showIcon = showIcon;
    _showImageView.image = [UIImage imageNamed:@""];
}

- (void)setShowTitle:(NSString *)showTitle {
    _showTitle = showTitle;
    _showLabel.text = showTitle;
}

- (void)setIsMore:(BOOL)isMore {
    _isMore = isMore;
    _moreLabel.hidden = !isMore;
}

- (void)setMoreTitle:(NSString *)moreTitle {
    _moreTitle = moreTitle;
    _moreLabel.text = moreTitle;
}

@end
