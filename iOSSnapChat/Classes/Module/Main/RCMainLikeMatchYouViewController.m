//
//  RCMainLikeMatchYouViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/25.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeMatchYouViewController.h"

@interface RCMainLikeMatchYouViewController ()
{
    UILabel *_snapChatIdLabel;
}

@end

@implementation RCMainLikeMatchYouViewController

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
    self.title = @"Match!";
}

- (void)setUpUI {
    
    UIImageView *meImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 64 + 40, (kRCScreenWidth - 30) / 2, (kRCScreenWidth - 30) / 2)];
    [meImageView sd_setImageWithURL:self.iconURLMe placeholderImage:[UIImage imageNamed:@"default.jpg"]];
    meImageView.layer.cornerRadius = (kRCScreenWidth - 30) / 2 / 2;
    meImageView.layer.masksToBounds = YES;
    [self.view addSubview:meImageView];
    
    UIImageView *ohterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + (kRCScreenWidth - 30) / 2, 64 + 40, (kRCScreenWidth - 30) / 2, (kRCScreenWidth - 30) / 2)];
    [ohterImageView sd_setImageWithURL:self.iconURLOhter placeholderImage:[UIImage imageNamed:@"default.jpg"]];
    ohterImageView.layer.cornerRadius = (kRCScreenWidth - 30) / 2 / 2;
    ohterImageView.layer.masksToBounds = YES;
    [self.view addSubview:ohterImageView];
    
    UIImageView *heartImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRCScreenWidth / 4, CGRectGetMaxY(meImageView.frame) + 40, kRCScreenWidth / 2, kRCScreenWidth / 2)];
    heartImageView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:heartImageView];
    
    UILabel *snapChatIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(heartImageView.frame) + 40, (kRCScreenWidth - 20) * 0.7, 40)];
    snapChatIdLabel.textAlignment = NSTextAlignmentCenter;
    snapChatIdLabel.backgroundColor = [UIColor lightGrayColor];
    snapChatIdLabel.text = self.snapchatid;
    [self.view addSubview:snapChatIdLabel];
    _snapChatIdLabel = snapChatIdLabel;
    
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    copyButton.frame = CGRectMake(CGRectGetMaxX(snapChatIdLabel.frame), CGRectGetMaxY(heartImageView.frame) + 40, (kRCScreenWidth - 20) * 0.3, 40);
    [copyButton addTarget:self action:@selector(copyButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [copyButton setTitle:@"Copy" forState:UIControlStateNormal];
    [copyButton setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:copyButton];
}

#pragma mark - Action
- (void)copyButtonDidClicked {
    [[UIPasteboard generalPasteboard] setString:_snapChatIdLabel.text];
    [RCMBHUDTool showText:@"已复制到剪贴板" hideDelay:1];
}

@end
