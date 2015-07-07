//
//  RCMainLikeTableViewCell.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/19.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeTableViewCell.h"

#define kRCMainLikeTableViewCellShowImageViewLeftConstant kRCAdaptationWidth(43)
#define kRCMainLikeTableViewCellShowImageViewWidthConstant kRCAdaptationWidth(30)
#define kRCMainLikeTableViewCellShowImageViewHeightConstant kRCAdaptationWidth(30)

#define kRCMainLikeTableViewCellShowLabelLeftConstant kRCAdaptationWidth(22)

#define kRCMainLikeTableViewCellMoreLabelRightConstant 0

#define kRCMainLikeTableViewCellSeparatorLineBottomConstant 0
#define kRCMainLikeTableViewCellSeparatorLineLeftConstant 0
#define kRCMainLikeTableViewCellSeparatorLineRightConstant 0
#define kRCMainLikeTableViewCellSeparatorLineHeightConstant 1

@interface RCMainLikeTableViewCell ()
{
    UIImageView *_showImageView;
    UILabel *_showLabel;
    UILabel *_moreLabel;
    UIView *_separatorLine;
}

@end

@implementation RCMainLikeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *showImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:showImageView];
        _showImageView = showImageView;
        
        UILabel *showLabel = [[UILabel alloc] init];
        showLabel.textColor = kRCDefaultDarkAlphaBlack;
        [self.contentView addSubview:showLabel];
        _showLabel = showLabel;
        
        UILabel *moreLabel = [[UILabel alloc] init];
        [self.contentView addSubview:moreLabel];
        _moreLabel = moreLabel;
        
        UIView *separatorLine = [[UIView alloc] init];
        separatorLine.backgroundColor = kRCDefaultLightgray;
        [self.contentView addSubview:separatorLine];
        _separatorLine = separatorLine;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_showImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_showImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:kRCMainLikeTableViewCellShowImageViewLeftConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_showImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeTableViewCellShowImageViewWidthConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_showImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeTableViewCellShowImageViewHeightConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_showImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [_showLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_showLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_showImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:kRCMainLikeTableViewCellShowLabelLeftConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_showLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [_moreLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_moreLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-kRCMainLikeTableViewCellMoreLabelRightConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_moreLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [_separatorLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeTableViewCellSeparatorLineBottomConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:kRCMainLikeTableViewCellSeparatorLineLeftConstant]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-kRCMainLikeTableViewCellSeparatorLineRightConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeTableViewCellSeparatorLineHeightConstant]];
}

- (void)setShowIcon:(UIImage *)showIcon {
    _showIcon = showIcon;
    _showImageView.image = showIcon;
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
