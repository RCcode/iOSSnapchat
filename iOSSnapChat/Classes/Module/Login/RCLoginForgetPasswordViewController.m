//
//  RCLoginForgetPasswordViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/13.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCLoginForgetPasswordViewController.h"

@interface RCLoginForgetPasswordViewController ()
{
    UITextField *_emailField;
}

@end

@implementation RCLoginForgetPasswordViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self inheritSetting];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility
- (void)inheritSetting {
    self.arrowTitle = @"";
}

- (void)setUpUI {
#warning frame
    
    //邮箱
    UITextField *emailField = [[UITextField alloc] initWithFrame:CGRectMake(20, 84, kRCScreenWidth - 40, 44)];
    emailField.placeholder =  @"Your Email Address";
    emailField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:emailField];
    _emailField = emailField;
    
    //邮箱分割线
    UIView *emailSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(emailField.frame), kRCScreenWidth, 1)];
    emailSeparatorLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:emailSeparatorLine];
    
    //Retrieve按钮
    UIButton *retrieveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    retrieveButton.frame = CGRectMake(20, kRCScreenHeight - 216 - 40 - 30 - 20, kRCScreenWidth - 40, 40);
    [retrieveButton setBackgroundColor:kRCSystemDefaultBlue];
    [retrieveButton setTitle:@"Retrieve Password" forState:UIControlStateNormal];
    [retrieveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [retrieveButton addTarget:self action:@selector(retrieveButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:retrieveButton];
    
    //描述文本
    NSString *descriptionText = @"Log in your Email and reset the password.";
    CGSize size = [descriptionText sizeForLineWithSize:CGSizeMake(kRCScreenWidth - 40, MAXFLOAT) Attributes:@{NSFontAttributeName: kRCSystemFont(14)}];
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMinY(retrieveButton.frame) - 20 - size.height, size.width, size.height)];
    msgLabel.font = kRCSystemFont(14);
    msgLabel.textColor = kRCSystemDefaultBlue;
    msgLabel.numberOfLines = 0;
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.text = descriptionText;
    [self.view addSubview:msgLabel];
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)retrieveButtonDidClicked {
    NSLog(@"retrieveButtonDidClicked");
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
