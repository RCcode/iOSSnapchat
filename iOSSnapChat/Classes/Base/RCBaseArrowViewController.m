//
//  RCBaseArrowViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/10.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCBaseArrowViewController.h"

@interface RCBaseArrowViewController ()
{
    UIBarButtonItem *_arrowBackButtonItem;
    UIBarButtonItem *_arrowBackTitleItem;
}

@end

@implementation RCBaseArrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpArrowBackButton:kRCLocalizedString(@"NULL")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//导航栏
- (void)setUpArrowBackButton:(NSString *)title {
    //ButtonItem
    UIButton *arrowBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
#warning modify
    arrowBackButton.frame = CGRectMake(0, 0, 20, 20);
    [arrowBackButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [arrowBackButton addTarget:self action:@selector(arrowBackDidClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *arrowBackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:arrowBackButton];
    _arrowBackButtonItem = arrowBackButtonItem;
    self.navigationItem.leftBarButtonItems = @[arrowBackButtonItem];
}

- (void)setArrowTitle:(NSString *)arrowTitle {
    _arrowTitle = arrowTitle;
    if ([arrowTitle isEqualToString:kRCLocalizedString(@"NULL")]) return;
    //LabelItem
    UILabel *arrowBackLabel = [[UILabel alloc] init];
    arrowBackLabel.frame = kRCDefaultNacgationBarTitleFrame;
    arrowBackLabel.text = arrowTitle;
    arrowBackLabel.textColor = [UIColor whiteColor];
    arrowBackLabel.font = kRCDefaultNacgationBarTitleFont;
    arrowBackLabel.text = arrowTitle;
    UIBarButtonItem *arrowBackTitleItem = [[UIBarButtonItem alloc] initWithCustomView:arrowBackLabel];
    _arrowBackTitleItem = arrowBackTitleItem;
    self.navigationItem.leftBarButtonItems = @[_arrowBackButtonItem, _arrowBackTitleItem];
}

- (void)arrowBackDidClicked {}

@end
