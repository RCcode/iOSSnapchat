//
//  RCRegisterAccountViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/9.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegisterAccountViewController.h"

#define kBackButtonF CGRectMake(0, 0, 44, 44)
#define kBackTitleF CGRectMake(0, 0, 200, 44)
#define kBackTitleFont kRCBoldSystemFont(17)

@interface RCRegisterAccountViewController ()

@end

@implementation RCRegisterAccountViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpArrowBackButton:kRCLocalizedString(@"SignUp")];
    self.view.backgroundColor = [UIColor whiteColor]; // delete
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Methods
//导航栏
- (void)setUpArrowBackButton:(NSString *)title {
    //ButtonItem
    UIButton *arrowBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    arrowBackButton.frame = kBackButtonF;
    [arrowBackButton setImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    [arrowBackButton addTarget:self action:@selector(arrowBackDidClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *arrowBackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:arrowBackButton];
    //LabelItem
    UILabel *arrowBackLabel = [[UILabel alloc] init];
    arrowBackLabel.frame = kBackTitleF;
    arrowBackLabel.text = title;
    arrowBackLabel.textColor = [UIColor whiteColor];
    arrowBackLabel.font = kBackTitleFont;
    UIBarButtonItem *arrowBackTitleItem = [[UIBarButtonItem alloc] initWithCustomView:arrowBackLabel];
    
    self.navigationItem.leftBarButtonItems = @[arrowBackButtonItem, arrowBackTitleItem];
}

#pragma mark - Actions
- (void)arrowBackDidClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
