//
//  RCHomePageCell.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/9.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCHomePageCell.h"

//Cell约束
#define kRCHomePageCellIntroduceLabelTopConstant kRCAdaptationHeight(20)
#define kRCHomePageCellIntroduceLabelBottomConstant kRCAdaptationHeight(10)
#define kRCHomePageCellIntroduceLabelLeftConstant kRCAdaptationWidth(40)
#define kRCHomePageCellIntroduceLabelRightConstant kRCAdaptationWidth(40)

#define kRCHomePageCellIntroduceLabelFont kRCSystemFont(kRCIOSBd(25))

#define kRCHomePageCellIntroduceintroduceImageViewTopConstant kRCAdaptationHeight(116)
#define kRCHomePageCellIntroduceintroduceImageViewWidthConstant kRCAdaptationWidth(640)
#define kRCHomePageCellIntroduceintroduceImageViewHeightConstant kRCAdaptationHeight(724)

@interface RCHomePageCell ()
{
    UIImageView *_bgImageView;
    UILabel *_introduceLabel;
    UIImageView *_introduceImageView;
}

@end

@implementation RCHomePageCell

#pragma mark - Setter
- (void)setIntroduceTitle:(NSString *)introduceTitle {
    _introduceTitle = introduceTitle;
    _introduceLabel.text = introduceTitle;
}

- (void)setIntroduceImage:(UIImage *)introduceImage {
    _introduceImage = introduceImage;
    _introduceImageView.image = introduceImage;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *introduceLabel = [[UILabel alloc] init];
        introduceLabel.font = kRCHomePageCellIntroduceLabelFont;
        introduceLabel.numberOfLines = 0;
        introduceLabel.textColor = colorWithHexString(@"9b55a0");
        introduceLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:introduceLabel];
        _introduceLabel = introduceLabel;
        
        UIImageView *introduceImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:introduceImageView];
        _introduceImageView = introduceImageView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_introduceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_introduceLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCHomePageCellIntroduceLabelTopConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_introduceLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_introduceImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:-kRCHomePageCellIntroduceLabelBottomConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_introduceLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCHomePageCellIntroduceLabelLeftConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_introduceLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCHomePageCellIntroduceLabelRightConstant]];
    
    [_introduceImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_introduceImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCHomePageCellIntroduceintroduceImageViewTopConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_introduceImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCHomePageCellIntroduceintroduceImageViewWidthConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_introduceImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCHomePageCellIntroduceintroduceImageViewHeightConstant]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_introduceImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
}

@end
