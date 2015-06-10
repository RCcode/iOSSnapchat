//
//  RCBaseArrowViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/10.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCBaseArrowViewController.h"

#define kBackButtonF CGRectMake(0, 0, 44, 44)
#define kBackTitleF CGRectMake(0, 0, 200, 44)
#define kBackTitleFont kRCBoldSystemFont(17)

@interface RCBaseArrowViewController ()
{
    UILabel *_arrowBackLabel;
}

@end

@implementation RCBaseArrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpArrowBackButton:kRCLocalizedString(@"Default")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//导航栏
- (void)setUpArrowBackButton:(NSString *)title {
    //ButtonItem
    UIButton *arrowBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    arrowBackButton.frame = kBackButtonF;
    [arrowBackButton setImage:kRCImage(@"arrow.png") forState:UIControlStateNormal];
    [arrowBackButton addTarget:self action:@selector(arrowBackDidClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *arrowBackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:arrowBackButton];
    //LabelItem
    UILabel *arrowBackLabel = [[UILabel alloc] init];
    arrowBackLabel.frame = kBackTitleF;
    arrowBackLabel.text = title;
    arrowBackLabel.textColor = [UIColor whiteColor];
    arrowBackLabel.font = kBackTitleFont;
    _arrowBackLabel = arrowBackLabel;
    UIBarButtonItem *arrowBackTitleItem = [[UIBarButtonItem alloc] initWithCustomView:arrowBackLabel];
    //LeftItems
    self.navigationItem.leftBarButtonItems = @[arrowBackButtonItem, arrowBackTitleItem];
}

- (void)setArrowTitle:(NSString *)arrowTitle {
    _arrowTitle = arrowTitle;
    _arrowBackLabel.text = arrowTitle;
}

- (void)arrowBackDidClicked {}

@end
