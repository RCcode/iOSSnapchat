//
//  RCMainLikeLikeYouViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/25.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeLikeYouViewController.h"
#import "RCMainLikeModel.h"

//主界面约束
#define kRCMainLikeLikeYouIconImageViewTopConstant (kRCAdaptationHeight(78) + 64)
#define kRCMainLikeLikeYouIconImageViewLeftConstant kRCAdaptationWidth(112)
#define kRCMainLikeLikeYouIconImageViewRightConstant kRCAdaptationWidth(112)
#define kRCMainLikeLikeYouIconImageViewHeightConstant (kRCScreenWidth - kRCAdaptationWidth(112) * 2)

#define kRCMainLikeLikeYouTextLabelTopConstant kRCAdaptationHeight(94)

#define kRCMainLikeLikeYouUnLikeButtonBottomConstant kRCAdaptationHeight(106)
#define kRCMainLikeLikeYouUnLikeButtonLeftConstant kRCAdaptationWidth(134)
#define kRCMainLikeLikeYouUnLikeButtonWidthConstant kRCAdaptationWidth(169)
#define kRCMainLikeLikeYouUnLikeButtonHeightConstant kRCAdaptationWidth(169)

#define kRCMainLikeLikeYouLikeButtonBottomConstant kRCAdaptationHeight(106)
#define kRCMainLikeLikeYouLikeButtonRightConstant kRCAdaptationWidth(134)
#define kRCMainLikeLikeYouLikeButtonWidthConstant kRCAdaptationWidth(169)
#define kRCMainLikeLikeYouLikeButtonHeightConstant kRCAdaptationWidth(169)

typedef NS_ENUM(NSInteger, kRCMainLikeType) {
    kRCMainLikeTypeUnlike = 0,
    kRCMainLikeTypeLike
};

@interface RCMainLikeLikeYouViewController ()
{
    UIImageView *_iconImageView;
    UILabel *_textLabel;
    UIButton *_unLikeButton;
    UIButton *_likeButton;
}

@end

@implementation RCMainLikeLikeYouViewController

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
    self.title = @"Like!";
}

- (void)setUpUI {
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.layer.masksToBounds = YES;
    [iconImageView sd_setImageWithURL:self.iconURL];
    [self.view addSubview:iconImageView];
    _iconImageView = iconImageView;
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = @"Like you!";
    textLabel.font = kRCBoldSystemFont(25);
    textLabel.textColor = kRCDefaultDarkAlphaBlack;
    [self.view addSubview:textLabel];
    _textLabel = textLabel;
    
    UIButton *unLikeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [unLikeButton addTarget:self action:@selector(choiceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    unLikeButton.tag = kRCMainLikeTypeUnlike;
    [unLikeButton setImage:kRCImage(@"pass_icon") forState:UIControlStateNormal];
    [unLikeButton setImage:kRCImage(@"pass_pass_icon") forState:UIControlStateHighlighted];
    [unLikeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:unLikeButton];
    _unLikeButton = unLikeButton;
    
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [likeButton addTarget:self action:@selector(choiceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    likeButton.tag = kRCMainLikeTypeLike;
    [likeButton setImage:kRCImage(@"like_icon") forState:UIControlStateNormal];
    [likeButton setImage:kRCImage(@"like_press_icon") forState:UIControlStateHighlighted];
    [likeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:likeButton];
    _likeButton = likeButton;
}

- (void)addConstraint {
    [_iconImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_iconImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCMainLikeLikeYouIconImageViewTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_iconImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeLikeYouIconImageViewLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_iconImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeLikeYouIconImageViewRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_iconImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeYouIconImageViewHeightConstant]];
    _iconImageView.layer.cornerRadius = kRCMainLikeLikeYouIconImageViewHeightConstant / 2;
    _iconImageView.layer.masksToBounds = YES;
    
    [_textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_textLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_iconImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCMainLikeLikeYouTextLabelTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_textLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [_unLikeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_unLikeButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeLikeYouUnLikeButtonBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_unLikeButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeLikeYouUnLikeButtonLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_unLikeButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeYouUnLikeButtonWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_unLikeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeYouUnLikeButtonHeightConstant]];
    
    [_likeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likeButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeLikeYouLikeButtonBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likeButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeLikeYouLikeButtonRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likeButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeYouLikeButtonWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeYouLikeButtonHeightConstant]];
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)choiceButtonDidClicked:(UIButton *)sender {
    [self sendLikeUnLikeRequest:sender.tag];
}

- (void)sendLikeUnLikeRequest:(kRCMainLikeType)type {
    NSString *usertoken = [[NSUserDefaults standardUserDefaults] stringForKey:kRCUserDefaultUserTokenKey];
    //发送请求
    RCMainLikeModel *mainLikeModel = [[RCMainLikeModel alloc] init];
    mainLikeModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/message/LikeUser.do";
    mainLikeModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    mainLikeModel.parameters = @{@"plat": @1,
                                 @"usertoken": usertoken,
                                 @"userid2": self.userid,
                                 @"flag": @(type)
                                 };
    
    [mainLikeModel requestServerWithModel:mainLikeModel success:^(id resultModel) {
        RCMainLikeModel *result = (RCMainLikeModel *)resultModel;
        if ([result.mess isEqualToString:@"succ"]) {
            if (type == kRCMainLikeTypeLike) {
                [RCMBHUDTool showText:@"Like" hideDelay:1];
            } else if (type == kRCMainLikeTypeUnlike) {
                [RCMBHUDTool showText:@"UnLike" hideDelay:1];
            }
        } else {
            NSLog(@"Like/UnLike操作失败");
            [RCMBHUDTool showText:@"操作失败，请重新Like/UnLike" hideDelay:1];
        }
    } failure:^(NSError *error) {
        NSLog(@"服务器错误");
    }];
}

@end
