//
//  RCMainLikeMessageTableViewCell.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/25.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeMessageTableViewCell.h"

#define kRCMainLikeMessageTableViewCellShowImageViewLeftConstant kRCAdaptationWidth(34)
#define kRCMainLikeMessageTableViewCellShowImageViewWidthConstant kRCAdaptationHeight(86)
#define kRCMainLikeMessageTableViewCellShowImageViewHeightConstant kRCAdaptationHeight(86)

#define kRCMainLikeMessageTableViewCelShowLabelLeftConstant kRCAdaptationWidth(28)

#define kRCMainLikeMessageTableViewCellMoreImageViewLeftConstant kRCAdaptationWidth(6)
#define kRCMainLikeMessageTableViewCellMoreImageViewWidthConstant kRCAdaptationWidth(31)
#define kRCMainLikeMessageTableViewCellMoreImageViewHeightConstant kRCAdaptationHeight(22)

#define kRCMainLikeMessageTableViewCelSeparatorLineBottomConstant 0
#define kRCMainLikeMessageTableViewCelSeparatorLineLeftConstant 0
#define kRCMainLikeMessageTableViewCelSeparatorLineRightConstant 0
#define kRCMainLikeMessageTableViewCelSeparatorLineHeightConstant 1

@interface RCMainLikeMessageTableViewCell ()
{
    UIImageView *_showImageView;
    UIImageView *_moreImageView;
    UIView *_separatorLine;
}

@end

@implementation RCMainLikeMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *showImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:showImageView];
        _showImageView = showImageView;
        
        UILabel *showLabel = [[UILabel alloc] init];
        [self.contentView addSubview:showLabel];
        _showLabel = showLabel;
        
        UIImageView *moreImageView = [[UIImageView alloc] initWithImage:kRCImage(@"match_icon")];
        [self.contentView addSubview:moreImageView];
        _moreImageView = moreImageView;
        
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
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_showImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:kRCMainLikeMessageTableViewCellShowImageViewLeftConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_showImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMessageTableViewCellShowImageViewWidthConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_showImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMessageTableViewCellShowImageViewHeightConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_showImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    _showImageView.layer.cornerRadius = kRCMainLikeMessageTableViewCellShowImageViewWidthConstant / 2;
    _showImageView.layer.masksToBounds = YES;
    
    [_showLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_showLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_showImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:kRCMainLikeMessageTableViewCelShowLabelLeftConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_showLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [_moreImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_moreImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_showLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:kRCMainLikeMessageTableViewCellMoreImageViewLeftConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_moreImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMessageTableViewCellMoreImageViewWidthConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_moreImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMessageTableViewCellMoreImageViewHeightConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_moreImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [_separatorLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeMessageTableViewCelSeparatorLineBottomConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:kRCMainLikeMessageTableViewCelSeparatorLineLeftConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-kRCMainLikeMessageTableViewCelSeparatorLineRightConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_separatorLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMessageTableViewCelSeparatorLineHeightConstant]];
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
