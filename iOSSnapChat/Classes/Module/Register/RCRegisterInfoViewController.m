//
//  RCRegisterInfoViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/10.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegisterInfoViewController.h"
#import "RCRegiseterInfoModel.h"
#import "RCRegisterUploadViewController.h"

typedef NS_ENUM(NSInteger, kRCRegisterInfoSexType) {
    kRCRegisterInfoSexTypeMale = 0,
    kRCRegisterInfoSexTypeFemale
};

#define kRCRegisterInfoViewAgeComponentNumber 1
#define kRCRegisterInfoViewAgeNumber (100 - 13 + 1)

//主界面约束
#define kRCRegisterInfoSnapChatFieldTopConstant (64 + 20)
#define kRCRegisterInfoSnapChatFieldLeftConstant (kRCAdaptationWidth(82) - 10)
#define kRCRegisterInfoSnapChatFieldRightConstant kRCAdaptationWidth(82)
#define kRCRegisterInfoSnapChatFieldHeightConstant (kRCAdaptationHeight(142) - 20)

#define kRCRegisterInfoSnapChatSeparatorLineTopConstant 0
#define kRCRegisterInfoSnapChatSeparatorLineLeftConstant kRCAdaptationWidth(82)
#define kRCRegisterInfoSnapChatSeparatorLineRightConstant kRCAdaptationWidth(82)
#define kRCRegisterInfoSnapChatSeparatorLineHeightConstant 1

#define kRCRegisterInfoAgeFieldTopConstant (0 + 20)
#define kRCRegisterInfoAgeFieldLeftConstant kRCAdaptationWidth(82)
#define kRCRegisterInfoAgeFieldRightConstant kRCAdaptationWidth(82)
#define kRCRegisterInfoAgeFieldHeightConstant (kRCAdaptationHeight(128) - 20)

#define kRCRegisterInfoAgeSeparatorLineTopConstant 0
#define kRCRegisterInfoAgeSeparatorLineLeftConstant kRCAdaptationWidth(82)
#define kRCRegisterInfoAgeSeparatorLineRightConstant kRCAdaptationWidth(82)
#define kRCRegisterInfoAgeSeparatorLineHeightConstant 1

#define kRCRegisterInfoGenderLabelTopConstant kRCAdaptationHeight(92)
#define kRCRegisterInfoGenderLabelLeftConstant kRCAdaptationWidth(82)
#define kRCRegisterInfoGenderLabelWidthConstant kRCAdaptationWidth(200)
#define kRCRegisterInfoGenderLabelHeightConstant kRCAdaptationHeight(40)

#define kRCRegisterInfoFemaleButtonTopConstant kRCAdaptationHeight(74)
#define kRCRegisterInfoFemaleButtonRightConstant kRCAdaptationWidth(48)
#define kRCRegisterInfoFemaleButtonWidthConstant kRCAdaptationHeight(72)
#define kRCRegisterInfoFemaleButtonHeightConstant kRCAdaptationHeight(72)

#define kRCRegisterInfoMaleButtonTopConstant kRCAdaptationHeight(74)
#define kRCRegisterInfoMaleButtonRightConstant kRCAdaptationWidth(108)
#define kRCRegisterInfoMaleButtonWidthConstant kRCAdaptationHeight(72)
#define kRCRegisterInfoMaleButtonHeightConstant kRCAdaptationHeight(72)

//年龄视图约束
#define kRCRegisterInfoAgeInputViewRect CGRectMake(0, 0, kRCScreenWidth, kRCAdaptationHeight(70) + 216)

#define kRCRegisterInfoAgeInputViewSeparatorLineTopConstant 0
#define kRCRegisterInfoAgeInputViewSeparatorLineLeftConstant 0
#define kRCRegisterInfoAgeInputViewSeparatorLineRightConstant 0
#define kRCRegisterInfoAgeInputViewSeparatorLineHeightConstant 1

#define kRCRegisterInfoAgeInputViewCompleteButtonTopConstant 0
#define kRCRegisterInfoAgeInputViewCompleteButtonRightConstant 0
#define kRCRegisterInfoAgeInputViewCompleteButtonWidthConstant 100
#define kRCRegisterInfoAgeInputViewCompleteButtonHeightConstant kRCAdaptationHeight(70)

#define kRCRegisterInfoAgeInputViewAgePickerViewTopConstant kRCAdaptationHeight(70)
#define kRCRegisterInfoAgeInputViewAgePickerViewBottomConstant 0
#define kRCRegisterInfoAgeInputViewAgePickerViewLeftConstant 0
#define kRCRegisterInfoAgeInputViewAgePickerViewRightConstant 0

@interface RCRegisterInfoViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    //MainUI
    UITextField *_snapChatField;
    UIView *_snapChatSeparatorLine;
    RCPikerViewTextFiled *_ageField;
    UIView *_ageSeparatorLine;
    UILabel *_genderLabel;
    UIButton *_femaleButton;
    UIButton *_maleButton;
    
    NSInteger _pickerViewSelectedAge;
    kRCRegisterInfoSexType _selectedSexType;
}

@end

@implementation RCRegisterInfoViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self inheritSetting];
    [self setUpUI];
    [self addConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[RCLocalTool shareManager] acquireLocation];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - Utility
- (void)inheritSetting {
    [self modifyNavgationBar];
}

- (void)setUpUI {
    UITextField *snapChatField = [[RCPlaceHolderAlwaysTextField alloc] init];
    snapChatField.delegate = self;
    snapChatField.placeholder = kRCLocalizedString(@"RegisterInfoYourSnapchatIDPlaceholder");
    [self.view addSubview:snapChatField];
    _snapChatField = snapChatField;
    
    UIView *snapChatSeparatorLine = [[UIView alloc] init];
    snapChatSeparatorLine.backgroundColor = kRCSystemLightgray;
    [self.view addSubview:snapChatSeparatorLine];
    _snapChatSeparatorLine = snapChatSeparatorLine;

    UIView *separatorLine = [[UIView alloc] init];
    separatorLine.backgroundColor = kRCSystemLightgray;
    UIButton *completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [completeButton addTarget:self action:@selector(completeButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [completeButton setTitleColor:kRCSystemLightgray forState:UIControlStateNormal];
    [completeButton setTitle:kRCLocalizedString(@"RegisterInfoCompleteButtonTitle") forState:UIControlStateNormal];
    UIPickerView *agePickerView = [[UIPickerView alloc] init];
    agePickerView.backgroundColor = colorWithHexString(@"ededed");
    agePickerView.dataSource = self;
    agePickerView.delegate = self;

    UIView *ageInputView = [[UIView alloc] initWithFrame:kRCRegisterInfoAgeInputViewRect];
    ageInputView.backgroundColor = kRCDefaultWhite;
    [ageInputView addSubview:separatorLine];
    [ageInputView addSubview:completeButton];
    [ageInputView addSubview:agePickerView];
    
    //约束
    [separatorLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [ageInputView addConstraint:[NSLayoutConstraint constraintWithItem:separatorLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:ageInputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCRegisterInfoAgeInputViewSeparatorLineTopConstant]];
    [ageInputView addConstraint:[NSLayoutConstraint constraintWithItem:separatorLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:ageInputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:kRCRegisterInfoAgeInputViewSeparatorLineLeftConstant]];
    [ageInputView addConstraint:[NSLayoutConstraint constraintWithItem:separatorLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:ageInputView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-kRCRegisterInfoAgeInputViewSeparatorLineRightConstant]];
    [ageInputView addConstraint:[NSLayoutConstraint constraintWithItem:separatorLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoAgeInputViewSeparatorLineHeightConstant]];
    [completeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [ageInputView addConstraint:[NSLayoutConstraint constraintWithItem:completeButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:ageInputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCRegisterInfoAgeInputViewCompleteButtonTopConstant]];
    [ageInputView addConstraint:[NSLayoutConstraint constraintWithItem:completeButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:ageInputView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-kRCRegisterInfoAgeInputViewCompleteButtonRightConstant]];
    [ageInputView addConstraint:[NSLayoutConstraint constraintWithItem:completeButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoAgeInputViewCompleteButtonWidthConstant]];
    [ageInputView addConstraint:[NSLayoutConstraint constraintWithItem:completeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoAgeInputViewCompleteButtonHeightConstant]];
    [agePickerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [ageInputView addConstraint:[NSLayoutConstraint constraintWithItem:agePickerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:ageInputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCRegisterInfoAgeInputViewAgePickerViewTopConstant]];
    [ageInputView addConstraint:[NSLayoutConstraint constraintWithItem:agePickerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:ageInputView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCRegisterInfoAgeInputViewAgePickerViewBottomConstant]];
    [ageInputView addConstraint:[NSLayoutConstraint constraintWithItem:agePickerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:ageInputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:kRCRegisterInfoAgeInputViewAgePickerViewLeftConstant]];
    [ageInputView addConstraint:[NSLayoutConstraint constraintWithItem:agePickerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:ageInputView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-kRCRegisterInfoAgeInputViewAgePickerViewRightConstant]];
    
    RCPikerViewTextFiled *ageField = [[RCPikerViewTextFiled alloc] init];
    ageField.delegate = self;
    ageField.userPlaceHolder = kRCLocalizedString(@"RegisterInfoAgePlaceholder");
    ageField.inputView = ageInputView;
    [self.view addSubview:ageField];
    _ageField = ageField;
    
    UIView *ageSeparatorLine = [[UIView alloc] init];
    ageSeparatorLine.backgroundColor = kRCSystemLightgray;
    [self.view addSubview:ageSeparatorLine];
    _ageSeparatorLine = ageSeparatorLine;
    
    UILabel *genderLabel = [[UILabel alloc] init];
    genderLabel.text = kRCLocalizedString(@"RegisterInfoGenderLabelTitle");
    genderLabel.textColor = kRCSystemLightgray;
    [self.view addSubview:genderLabel];
    _genderLabel = genderLabel;
    
    UIButton *femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [femaleButton setAdjustsImageWhenHighlighted:NO];
    [femaleButton setBackgroundImage:kRCImage(@"icon_girl_unchoose") forState:UIControlStateNormal];
    [femaleButton setBackgroundImage:kRCImage(@"icon_girl_choose") forState:UIControlStateSelected];
    femaleButton.selected = YES;
    [femaleButton addTarget:self action:@selector(femaleButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:femaleButton];
    _femaleButton = femaleButton;
    
    UIButton *maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [maleButton setAdjustsImageWhenHighlighted:NO];
    [maleButton setBackgroundImage:kRCImage(@"icon_boy_unchoose") forState:UIControlStateNormal];
    [maleButton setBackgroundImage:kRCImage(@"icon_boy_choose") forState:UIControlStateSelected];
    [maleButton addTarget:self action:@selector(maleButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:maleButton];
    _maleButton = maleButton;
}

- (void)addConstraint {
    [_snapChatField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_snapChatField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCRegisterInfoSnapChatFieldTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_snapChatField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCRegisterInfoSnapChatFieldLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_snapChatField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCRegisterInfoSnapChatFieldRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_snapChatField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoSnapChatFieldHeightConstant]];
    
    [_snapChatSeparatorLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_snapChatSeparatorLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_snapChatField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCRegisterInfoSnapChatSeparatorLineTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_snapChatSeparatorLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCRegisterInfoSnapChatSeparatorLineLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_snapChatSeparatorLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCRegisterInfoSnapChatSeparatorLineRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_snapChatSeparatorLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoSnapChatSeparatorLineHeightConstant]];
    
    [_ageField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_ageField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_snapChatSeparatorLine attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCRegisterInfoAgeFieldTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_ageField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCRegisterInfoAgeFieldLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_ageField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCRegisterInfoAgeFieldRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_ageField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoAgeFieldHeightConstant]];
    
    [_ageSeparatorLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_ageSeparatorLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_ageField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCRegisterInfoAgeSeparatorLineTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_ageSeparatorLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCRegisterInfoAgeSeparatorLineLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_ageSeparatorLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCRegisterInfoAgeSeparatorLineRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_ageSeparatorLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoAgeSeparatorLineHeightConstant]];
    
    [_genderLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_genderLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_ageSeparatorLine attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCRegisterInfoGenderLabelTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_genderLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCRegisterInfoGenderLabelLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_genderLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoGenderLabelWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_genderLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoGenderLabelHeightConstant]];
    
    [_femaleButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_femaleButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_ageSeparatorLine attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCRegisterInfoFemaleButtonTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_femaleButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_maleButton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-kRCRegisterInfoFemaleButtonRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_femaleButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoFemaleButtonWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_femaleButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoFemaleButtonHeightConstant]];
    
    [_maleButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_maleButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_ageSeparatorLine attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCRegisterInfoMaleButtonTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_maleButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCRegisterInfoMaleButtonRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_maleButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoMaleButtonWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_maleButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoMaleButtonHeightConstant]];
}

- (void)modifyNavgationBar {
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = kRCDefaultNacgationBarItemFrame;
    [doneButton setTitle:kRCLocalizedString(@"RegisterInfoDoneItemTitle") forState:UIControlStateNormal];
    [doneButton setTitleColor:kRCDefaultAlphaWhite forState:UIControlStateDisabled];
    doneButton.titleLabel.font = kRCBoldSystemFont(17);
    [doneButton addTarget:self action:@selector(doneButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    [doneButtonItem setEnabled:NO];
    self.navigationItem.rightBarButtonItem = doneButtonItem;
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)femaleButtonDidClicked:(UIButton *)femaleButton {
    _femaleButton.selected = YES;
    _maleButton.selected = NO;
    _selectedSexType = kRCRegisterInfoSexTypeFemale;
}

- (void)maleButtonDidClicked:(UIButton *)maleButton {
    _femaleButton.selected = NO;
    _maleButton.selected = YES;
    _selectedSexType = kRCRegisterInfoSexTypeMale;
}

- (void)completeButtonDidClick {
    _ageField.userText = [NSString stringWithFormat:@"%zd", _pickerViewSelectedAge];
    self.navigationItem.rightBarButtonItem.enabled = (_snapChatField.text.length > 0) ? YES : NO;
    [self.view endEditing:YES];
}

- (void)doneButtonDidClicked {
    //获取用户存储的物理地址信息,usertoken
    kAcquireUserDefaultAll
    //请求设置
    RCRegiseterInfoModel *registerInfoModel = [[RCRegiseterInfoModel alloc] init];
    registerInfoModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    registerInfoModel.requestUrl = [Global shareGlobal].registerInfoURLString;
    registerInfoModel.parameters = @{@"plat": @1,
                                     @"usertoken": usertoken,
                                     @"countryid": coutryID,
                                     @"cityid": cityID,
                                     @"lon": @(longitude),
                                     @"lat": @(latitude),
                                     @"pushtoken": pushtoken,
                                     @"age": @(_pickerViewSelectedAge),
                                     @"gender": @(_selectedSexType),
                                     @"snapchatid": _snapChatField.text
                                     };
    //发送请求
    [RCMBHUDTool showIndicator];
    [registerInfoModel requestServerWithModel:registerInfoModel success:^(id resultModel) {
        RCRegiseterInfoModel *result = (RCRegiseterInfoModel *)resultModel;
        [userDefault setInteger:[result.step intValue] forKey:kRCUserDefaultResgisterStepKey];
        [RCMBHUDTool showIndicator];
        if ([result.state intValue] == 10000) {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:kRCLocalizedString(@"RegisterAccountInfoErrorCodeRepeatAccount") hideDelay:1.0f];
            RCRegisterUploadViewController *registerUploadVc = [[RCRegisterUploadViewController alloc] init];
            [self.navigationController pushViewController:registerUploadVc animated:YES];
        } else if ([result.state intValue] == 10004) {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:kRCLocalizedString(@"RegisterAccountInfoErrorCodeUsertokenError") hideDelay:1.0f];
        } else {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:kRCLocalizedString(@"RegisterAccountInfoErrorCodeCannotConnectServer") hideDelay:1.0f];
        }
    } failure:^(NSError *error) {
        [RCMBHUDTool hideshowIndicator];
        [RCMBHUDTool showText:kRCLocalizedString(@"RegisterAccountInfoErrorCodeNetworkError") hideDelay:1.0f];
    }];
}

#pragma mark - <UIPickerViewDataSource, UIPickerViewDelegate>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return kRCRegisterInfoViewAgeComponentNumber;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return kRCRegisterInfoViewAgeNumber;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%zd",row + 13];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _pickerViewSelectedAge = row;
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _snapChatField) {
        self.navigationItem.rightBarButtonItem.enabled = ((string.length == 0 && textField.text.length > 1 && _ageField.userText.length > 0) || (string.length > 0 && _ageField.userText.length > 0))  ? YES : NO;
    } else if (textField == _ageField) {
        self.navigationItem.rightBarButtonItem.enabled = ((string.length == 0 && textField.text.length > 1 && _snapChatField.text.length > 0) || (string.length > 0 && _snapChatField.text.length > 0))  ? YES : NO;
    }
    return YES;
}

@end
