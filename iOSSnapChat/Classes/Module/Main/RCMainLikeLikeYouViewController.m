//
//  RCMainLikeLikeYouViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/25.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeLikeYouViewController.h"
#import "RCMainLikeModel.h"

typedef NS_ENUM(NSInteger, kRCMainLikeType) {
    kRCMainLikeTypeUnlike = 0,
    kRCMainLikeTypeLike
};

@interface RCMainLikeLikeYouViewController ()

@end

@implementation RCMainLikeLikeYouViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navgationSettings];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility
- (void)navgationSettings {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Like!";
}

- (void)setUpUI {
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 64 + 40, kRCScreenWidth - 80, kRCScreenWidth - 80)];
    iconImageView.layer.cornerRadius = (kRCScreenWidth - 80) / 2;
    iconImageView.layer.masksToBounds = YES;
    [iconImageView sd_setImageWithURL:self.iconURL placeholderImage:[UIImage imageNamed:@"default.jpg"]];
    [self.view addSubview:iconImageView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconImageView.frame) + 40, kRCScreenWidth, 40)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = @"Like you!";
    [self.view addSubview:textLabel];
    
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = CGRectMake(40, CGRectGetMaxY(textLabel.frame) + 40, 80, 80);
    [likeButton addTarget:self action:@selector(choiceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [likeButton setTitle:@"Like" forState:UIControlStateNormal];
    likeButton.tag = kRCMainLikeTypeLike;
    [likeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:likeButton];
    
    UIButton *unLikeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    unLikeButton.frame = CGRectMake(kRCScreenWidth - 40 - 80, CGRectGetMaxY(textLabel.frame) + 40, 80, 80);
    [unLikeButton addTarget:self action:@selector(choiceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [unLikeButton setTitle:@"UnLike" forState:UIControlStateNormal];
    unLikeButton.tag = kRCMainLikeTypeUnlike;
    [unLikeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:unLikeButton];
}

#pragma mark - Action
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
