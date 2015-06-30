//
//  RCHomePageCell.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/9.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCHomePageCell.h"

@interface RCHomePageCell ()
{
    UIImageView *_bgImageView;
    UILabel *_introduceLabel;
    UIImageView *_introduceImageView;
}

@end

@implementation RCHomePageCell

#pragma mark - Setter
- (void)setBgImage:(UIImage *)bgImage {
    _bgImage = bgImage;
    _bgImageView.image = bgImage;
}

- (void)setIntroduceTitle:(NSString *)introduceTitle {
    _introduceTitle = introduceTitle;
    _introduceLabel.text = introduceTitle;
}

- (void)setIntroduceImage:(UIImage *)introduceImage {
    _introduceImage = introduceImage;
    _introduceImageView.image = introduceImage;
}

- (instancetype)initWithFrame:(CGRect)frame {
#warning 约束
    if (self = [super initWithFrame:frame]) {
        UIImageView *bgImageView = [[UIImageView alloc] init];
        bgImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:bgImageView];
        _bgImageView = bgImageView;
 
        UILabel *introduceLabel = [[UILabel alloc] init];
        introduceLabel.font = kRCSystemFont(kRCIOSBd(25));
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
    _bgImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _introduceLabel.frame = CGRectMake(20, 0, self.frame.size.width - 40, 60);
    _introduceImageView.frame = CGRectMake((self.frame.size.width - kRCIOSPt(614)) / 2, 60, kRCIOSPt(614), kRCIOSPt(1208));
}


@end
