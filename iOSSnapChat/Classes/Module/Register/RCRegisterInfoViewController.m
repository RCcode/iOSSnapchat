//
//  RCRegisterInfoViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/10.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegisterInfoViewController.h"

@interface RCRegisterInfoViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    RCPlaceHolderAlwaysTextField *_snapChatField;
    RCPikerViewTextFiled *_ageField;
    NSInteger _pickerViewSelectedAge;
}

@end

@implementation RCRegisterInfoViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self modifyNavgationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility
- (void)setUpUI {
#warning Modify Frame/Number
    self.arrowTitle = kRCLocalizedString(@"NULL");
    self.view.backgroundColor = [UIColor whiteColor];
    //SnapChat账号
    RCPlaceHolderAlwaysTextField *snapChatField = [[RCPlaceHolderAlwaysTextField alloc] initWithFrame:CGRectMake(40, 84, kRCScreenWidth - 80, 44)];
    snapChatField.userPlaceHolder = @"Your Snapchat ID";
    [self.view addSubview:snapChatField];
    _snapChatField = snapChatField;
    //SnapChat账号分割线
    UIView *snapChatSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(snapChatField.frame), kRCScreenWidth - 80, 1)];
    snapChatSeparatorLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:snapChatSeparatorLine];
    //年龄InputView
    UIButton *completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [completeButton addTarget:self action:@selector(completeButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    completeButton.frame = CGRectMake(kRCScreenWidth - 100, 0, 100, 20);
    [completeButton setTitle:@"Complete" forState:UIControlStateNormal];
    UIPickerView *agePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20, kRCScreenWidth, 216)];
    agePickerView.dataSource = self;
    agePickerView.delegate = self;
    UIView *ageInputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRCScreenWidth, 216 + 20)];
    [ageInputView addSubview:completeButton];
    [ageInputView addSubview:agePickerView];
    //年龄
    RCPikerViewTextFiled *ageField = [[RCPikerViewTextFiled alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(snapChatField.frame) + 20, kRCScreenWidth - 80, 44)];
    ageField.userPlaceHolder = @"Age";
    ageField.inputView = ageInputView;
    [self.view addSubview:ageField];
    _ageField = ageField;
    //年龄分割线
    UIView *ageSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(ageField.frame), kRCScreenWidth - 80, 1)];
    ageSeparatorLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:ageSeparatorLine];
    //性别
    UILabel *genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(ageField.frame) + 20, (kRCScreenWidth - 80) * 0.5, 44)];
    genderLabel.text = @"Gender";
    genderLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:genderLabel];
    //女性图片
    UIImageView *femaleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(genderLabel.frame), CGRectGetMaxY(ageField.frame) + 20, (kRCScreenWidth - 80) * 0.25, 44)];
    femaleImageView.image = kRCImage(@"");
    [self.view addSubview:femaleImageView];
    //男性图片
    UIImageView *maleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(femaleImageView.frame), CGRectGetMaxY(ageField.frame) + 20, (kRCScreenWidth - 80) * 0.25, 44)];
    maleImageView.image = kRCImage(@"");
    [self.view addSubview:maleImageView];
}

- (void)modifyNavgationBar {
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 0, 44, 44);
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    doneButton.titleLabel.font = kRCBoldSystemFont(17);
    [doneButton addTarget:self action:@selector(doneButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    self.navigationItem.rightBarButtonItem = doneButtonItem;
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//InputView完成按钮事件
- (void)completeButtonDidClick {
    _ageField.userText = [NSString stringWithFormat:@"%zd", _pickerViewSelectedAge];
    [self.view endEditing:YES];
}

//导航栏Done按钮事件
- (void)doneButtonDidClicked {
    NSLog(@"Done");
}

#pragma mark - <UIPickerViewDataSource, UIPickerViewDelegate>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 100;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%zd",row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _pickerViewSelectedAge = row;
}

@end
