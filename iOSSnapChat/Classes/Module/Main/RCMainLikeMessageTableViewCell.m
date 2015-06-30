//
//  RCMainLikeMessageTableViewCell.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/25.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeMessageTableViewCell.h"

@interface RCMainLikeMessageTableViewCell ()
{
    UIImageView *_showImageView;
    UILabel *_showLabel;
    UIImageView *_moreImageView;
    UIView *_separatorLineView;
}

@end

@implementation RCMainLikeMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *showImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:showImageView];
        _showImageView = showImageView;
        
        UILabel *showLabel = [[UILabel alloc] init];
        [self.contentView addSubview:showLabel];
        _showLabel = showLabel;
        
        UIImageView *moreImageView = [[UIImageView alloc] init];
        moreImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:moreImageView];
        _moreImageView = moreImageView;
        
        UIView *separatorLineView = [[UIView alloc] init];
        separatorLineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:separatorLineView];
        _separatorLineView = separatorLineView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _showImageView.frame = CGRectMake(5, 5, self.frame.size.height - 10, self.frame.size.height - 10);
    _showLabel.frame = CGRectMake(CGRectGetMaxX(_showImageView.frame) + 5, 5, 200, self.frame.size.height - 10);
    _moreImageView.frame = CGRectMake(CGRectGetMaxX(_showLabel.frame) + 5, 5, self.frame.size.height - 10, self.frame.size.height - 10);
    _separatorLineView.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
}

- (void)setShowIconURL:(NSURL *)showIconURL {
    _showIconURL = showIconURL;
    [_showImageView sd_setImageWithURL:showIconURL placeholderImage:[UIImage imageNamed:@"default.jpg"]];
}

- (void)setShowTitle:(NSString *)showTitle {
    _showTitle = showTitle;
    _showLabel.text = showTitle;
}

- (void)setIsMore:(BOOL)isMore {
    _isMore = isMore;
    _moreImageView.hidden = !isMore;
}

@end
