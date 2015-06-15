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

@interface RCRegisterInfoViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    RCLocalTool *_localTool;
    UITextField *_snapChatField;
    RCPikerViewTextFiled *_ageField;
    NSInteger _pickerViewSelectedAge;
    kRCRegisterInfoSexType _selectedSexType;
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_localTool == nil) _localTool = [[RCLocalTool alloc] init];
    [_localTool acquireLocation];
}

#pragma mark - Utility
- (void)setUpUI {
#warning Modify Frame/Number
    self.arrowTitle = kRCLocalizedString(@"RegisterInfoNULL");
    self.view.backgroundColor = [UIColor whiteColor];
    
    //SnapChat账号
    UITextField *snapChatField = [[RCPlaceHolderAlwaysTextField alloc] initWithFrame:CGRectMake(40, 84, kRCScreenWidth - 80, 44)];
    snapChatField.placeholder = kRCLocalizedString(@"RegisterInfoYourSnapchatID");
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
    [completeButton setTitle:kRCLocalizedString(@"RegisterInfoComplete") forState:UIControlStateNormal];
    UIPickerView *agePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20, kRCScreenWidth, 216)];
    agePickerView.dataSource = self;
    agePickerView.delegate = self;
    UIView *ageInputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRCScreenWidth, 216 + 20)];
    [ageInputView addSubview:completeButton];
    [ageInputView addSubview:agePickerView];
    
    //年龄
    RCPikerViewTextFiled *ageField = [[RCPikerViewTextFiled alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(snapChatField.frame) + 20, kRCScreenWidth - 80, 44)];
    ageField.userPlaceHolder = kRCLocalizedString(@"RegisterInfoAge");
    ageField.inputView = ageInputView;
    [self.view addSubview:ageField];
    _ageField = ageField;
    
    //年龄分割线
    UIView *ageSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(ageField.frame), kRCScreenWidth - 80, 1)];
    ageSeparatorLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:ageSeparatorLine];
    //性别
    UILabel *genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(ageField.frame) + 20, (kRCScreenWidth - 80) * 0.5, 44)];
    genderLabel.text = kRCLocalizedString(@"RegisterInfoGender");
    genderLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:genderLabel];
    
    //女性图片
    UIButton *femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    femaleButton.frame = CGRectMake(CGRectGetMaxX(genderLabel.frame) - 20, CGRectGetMaxY(ageField.frame) + 20, (kRCScreenWidth - 80) * 0.25, 44);
    [femaleButton setBackgroundImage:kRCImage(@"") forState:UIControlStateNormal];
    [femaleButton setBackgroundColor:[UIColor magentaColor]];
    [femaleButton addTarget:self action:@selector(femaleButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:femaleButton];

    //男性图片
    UIButton *maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    maleButton.frame = CGRectMake(CGRectGetMaxX(femaleButton.frame) + 20, CGRectGetMaxY(ageField.frame) + 20, (kRCScreenWidth - 80) * 0.25, 44);
    [maleButton setBackgroundImage:kRCImage(@"") forState:UIControlStateNormal];
    [maleButton setBackgroundColor:[UIColor blueColor]];
    [maleButton addTarget:self action:@selector(maleButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:maleButton];
}

- (void)modifyNavgationBar {
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 0, 44, 44);
    [doneButton setTitle:kRCLocalizedString(@"RegisterInfoDone") forState:UIControlStateNormal];
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

- (void)femaleButtonDidClicked {
    _selectedSexType = kRCRegisterInfoSexTypeFemale;
}

- (void)maleButtonDidClicked {
    _selectedSexType = kRCRegisterInfoSexTypeMale;
}

- (void)completeButtonDidClick {
    _ageField.userText = [NSString stringWithFormat:@"%zd", _pickerViewSelectedAge];
    [self.view endEditing:YES];
}

- (void)doneButtonDidClicked {
    
    //判断snaochatid年龄是否为空
    if ([_snapChatField.text isEqualToString:@""]) {
        [RCMBHUDTool showText:@"SnapChatID不能为空" hideDelay:1.0f];
        return;
    } else if (_ageField.userText == nil) {
        [RCMBHUDTool showText:@"年龄不能为空" hideDelay:1.0f];
        return;
    }
    
    //获取用户存储的物理地址信息,usertoken
    kAcquireUserDefaultLocalInfo
    NSString *usertoken = [userDefault stringForKey:kRCUserDefaultUserTokenKey];
    
    //请求设置
    RCRegiseterInfoModel *registerInfoModel = [[RCRegiseterInfoModel alloc] init];
    registerInfoModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    registerInfoModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/Regi2.do";
    registerInfoModel.parameters = @{@"plat": @1,
                                     @"usertoken": usertoken,
                                     @"countryid": coutryID,
                                     @"cityid": cityID,
                                     @"lon": @(longitude),
                                     @"lat": @(latitude),
                                     @"pushtoken": @"123",
                                     @"age": @(_pickerViewSelectedAge),
                                     @"gender": @(_selectedSexType),
                                     @"snapchatid": _snapChatField.text
                                     };

    //发送请求
    [RCMBHUDTool showIndicator];
    [registerInfoModel requestServerWithModel:registerInfoModel success:^(id resultModel) {
        RCRegiseterInfoModel *result = (RCRegiseterInfoModel *)resultModel;
        [RCMBHUDTool hideshowIndicator];
        if ([result.mess isEqualToString:@"succ"]) {
            [RCMBHUDTool hideshowIndicator];
            RCRegisterUploadViewController *registerUploadVc = [[RCRegisterUploadViewController alloc] init];
            [self.navigationController pushViewController:registerUploadVc animated:YES];
        } else if ([result.mess isEqualToString:@"usertoken error"]) {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:@"usertoken error" hideDelay:1.0f];
        } else {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:@"服务器异常" hideDelay:1.0f];
        }
        
    } failure:^(NSError *error) {
        [RCMBHUDTool hideshowIndicator];
        [RCMBHUDTool showText:@"请检查网络" hideDelay:1.0f];
    }];
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
