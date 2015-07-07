//
//  RCMainLikeMatchYouViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/25.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeMatchYouViewController.h"

//主界面约束
#define kRCMainLikeMatchYouMeImageViewTopConstant (kRCAdaptationHeight(114) + 64)
#define kRCMainLikeMatchYouMeImageViewLeftConstant kRCAdaptationWidth(14)
#define kRCMainLikeMatchYouMeImageViewWidthConstant ((kRCScreenWidth - kRCAdaptationWidth(14) * 3) / 2)
#define kRCMainLikeMatchYouMeImageViewHeightConstant ((kRCScreenWidth - kRCAdaptationWidth(14) * 3) / 2)

#define kRCMainLikeMatchYouOtherImageViewTopConstant (kRCAdaptationHeight(114) + 64)
#define kRCMainLikeMatchYouOtherImageViewRightConstant kRCAdaptationWidth(14)
#define kRCMainLikeMatchYouOtherImageViewWidthConstant ((kRCScreenWidth - kRCAdaptationWidth(14) * 3) / 2)
#define kRCMainLikeMatchYouOtherImageViewHeightConstant ((kRCScreenWidth - kRCAdaptationWidth(14) * 3) / 2)

#define kRCMainLikeMatchYouHeartImageViewTopConstant kRCAdaptationHeight(50)
#define kRCMainLikeMatchYouHeartImageViewWidthConstant kRCAdaptationWidth(322)
#define kRCMainLikeMatchYouHeartImageViewHeightConstant kRCAdaptationHeight(270)

#define kRCMainLikeMatchYouMatchLabelBottomConstant kRCAdaptationHeight(217)

#define kRCMainLikeMatchYouSnapChatIdLabelBottomConstant kRCAdaptationHeight(134)
#define kRCMainLikeMatchYouSnapChatIdLabelLeftConstant kRCAdaptationWidth(34)
#define kRCMainLikeMatchYouSnapChatIdLabelRightConstant 0
#define kRCMainLikeMatchYouSnapChatIdLabelHeightConstant kRCAdaptationHeight(78)

#define kRCMainLikeMatchYouCopyButtonBottomConstant kRCAdaptationHeight(134)
#define kRCMainLikeMatchYouCopyButtonRightConstant kRCAdaptationWidth(34)
#define kRCMainLikeMatchYouCopyButtonWidthConstant kRCAdaptationWidth(164)
#define kRCMainLikeMatchYouCopyButtonHeightConstant kRCAdaptationHeight(78)

@interface RCMainLikeMatchYouViewController ()
{
    UIImageView *_meImageView;
    UIImageView *_otherImageView;
    UIImageView *_heartImageView;
    UILabel *_matchLabel;
    UILabel *_snapChatIdLabel;
    UIButton *_copyButton;
}

@end

@implementation RCMainLikeMatchYouViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navgationSettings];
    [self setUpUI];
    [self addConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility
- (void)navgationSettings {
    self.title = @"Match!";
}

- (void)setUpUI {
    UIImageView *meImageView = [[UIImageView alloc] init];
    [meImageView sd_setImageWithURL:self.iconURLMe];
    [self.view addSubview:meImageView];
    _meImageView = meImageView;
    
    UIImageView *otherImageView = [[UIImageView alloc] init];
    [otherImageView sd_setImageWithURL:self.iconURLOhter];
    [self.view addSubview:otherImageView];
    _otherImageView = otherImageView;
    
    UIImageView *heartImageView = [[UIImageView alloc] initWithImage:kRCImage(@"aixin_icon")];
    [self.view addSubview:heartImageView];
    _heartImageView = heartImageView;
    
    UILabel *matchLabel = [[UILabel alloc] init];
    matchLabel.text = @"Matching Success!";
    matchLabel.textColor = colorWithHexString(@"aa72ae");
    matchLabel.font = kRCBoldSystemFont(25);
    [self.view addSubview:matchLabel];
    _matchLabel = matchLabel;
    
    UILabel *snapChatIdLabel = [[UILabel alloc] init];
    snapChatIdLabel.textAlignment = NSTextAlignmentCenter;
    snapChatIdLabel.textColor = kRCDefaultDarkAlphaBlack;
    snapChatIdLabel.backgroundColor = colorWithHexString(@"eeeeee");
    snapChatIdLabel.text = self.snapchatid;
    [self.view addSubview:snapChatIdLabel];
    _snapChatIdLabel = snapChatIdLabel;
    
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyButton addTarget:self action:@selector(copyButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [copyButton setTitle:@"Copy" forState:UIControlStateNormal];
    [copyButton setBackgroundColor:kRCDefaultBlue];
    [self.view addSubview:copyButton];
    _copyButton = copyButton;
}

- (void)addConstraint {
    [_meImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_meImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCMainLikeMatchYouMeImageViewTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_meImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeMatchYouMeImageViewLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_meImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMatchYouMeImageViewWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_meImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMatchYouMeImageViewHeightConstant]];
    _meImageView.layer.cornerRadius = kRCMainLikeMatchYouMeImageViewHeightConstant / 2;
    _meImageView.layer.masksToBounds = YES;
    
    [_otherImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_otherImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCMainLikeMatchYouOtherImageViewTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_otherImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeMatchYouOtherImageViewRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_otherImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMatchYouOtherImageViewWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_otherImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMatchYouOtherImageViewHeightConstant]];
    _otherImageView.layer.cornerRadius = kRCMainLikeMatchYouOtherImageViewHeightConstant / 2;
    _otherImageView.layer.masksToBounds = YES;
    
    [_heartImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_heartImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_meImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCMainLikeMatchYouHeartImageViewTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_heartImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMatchYouHeartImageViewWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_heartImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMatchYouHeartImageViewHeightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_heartImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [_matchLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_matchLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_heartImageView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_matchLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_snapChatIdLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:-kRCMainLikeMatchYouMatchLabelBottomConstant]];
    
    [_snapChatIdLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_snapChatIdLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeMatchYouSnapChatIdLabelBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_snapChatIdLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeMatchYouSnapChatIdLabelLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_snapChatIdLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_copyButton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-kRCMainLikeMatchYouSnapChatIdLabelRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_snapChatIdLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMatchYouSnapChatIdLabelHeightConstant]];
    
    [_copyButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_copyButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeMatchYouCopyButtonBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_copyButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeMatchYouCopyButtonRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_copyButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMatchYouCopyButtonWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_copyButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMatchYouCopyButtonHeightConstant]];
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)copyButtonDidClicked {
    [[UIPasteboard generalPasteboard] setString:_snapChatIdLabel.text];
    [RCMBHUDTool showText:@"已复制到剪贴板" hideDelay:1];
}

@end
