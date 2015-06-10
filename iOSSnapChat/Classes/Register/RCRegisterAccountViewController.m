//
//  RCRegisterAccountViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/9.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegisterAccountViewController.h"
#import "RCRegiseterAccountModel.h"

#define kBackButtonF CGRectMake(0, 0, 44, 44)
#define kBackTitleF CGRectMake(0, 0, 200, 44)
#define kBackTitleFont kRCBoldSystemFont(17)

@interface RCRegisterAccountViewController ()
{
    UITextField *_emailField;
    UITextField *_passwordField;
    BOOL _keyboardShow;
}

@end

@implementation RCRegisterAccountViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpArrowBackButton:kRCLocalizedString(@"SignUp")];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Utility
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
    UIBarButtonItem *arrowBackTitleItem = [[UIBarButtonItem alloc] initWithCustomView:arrowBackLabel];
    //LeftItems
    self.navigationItem.leftBarButtonItems = @[arrowBackButtonItem, arrowBackTitleItem];
}

//子控件
- (void)setUpUI {
#warning Modify Frame/Number
    self.view.backgroundColor = [UIColor whiteColor];
    //邮箱
    UITextField *emailField = [[UITextField alloc] initWithFrame:CGRectMake(20, 84, kRCScreenWidth - 40, 44)];
    emailField.placeholder =  kRCLocalizedString(@"EmailAddress");
    [emailField addTarget:self action:@selector(keyBoardDidShow) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:emailField];
    _emailField = emailField;
    //邮箱分割线
    UIView *emailSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_emailField.frame), kRCScreenWidth, 1)];
    emailSeparatorLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:emailSeparatorLine];
    //密码
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_emailField.frame) + 20, kRCScreenWidth - 40, 44)];
    [passwordField addTarget:self action:@selector(keyBoardDidShow) forControlEvents:UIControlEventEditingDidBegin];
    passwordField.placeholder = kRCLocalizedString(@"Password");
    [self.view addSubview:passwordField];
    _passwordField = passwordField;
    //密码分割线
    UIView *passwordSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_passwordField.frame), kRCScreenWidth, 1)];
    passwordSeparatorLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:passwordSeparatorLine];
    //Confirm按钮
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(20, kRCScreenHeight - 216 - 40 - 30 - 20, kRCScreenWidth - 40, 40);
    [confirmButton setBackgroundColor:kRCRGBAColor(30, 190, 205, 1)];
    [confirmButton setTitle:@"Confirm" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    if (_keyboardShow == NO) {
        [self keyBoardDidHid];
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHid) name:UIKeyboardDidHideNotification object:nil];
        [self.view endEditing:YES];
        _keyboardShow = NO;
    }
}

//键盘消失
- (void)keyBoardDidHid {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//键盘出现
- (void)keyBoardDidShow {
    _keyboardShow = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    _keyboardShow = NO;
}

//确认confirm点击事件
- (void)confirmDidClicked {
    if ([self validateEmail:_emailField.text]) {
        NSLog(@"Email = %@, password = %@", _emailField.text, _passwordField.text);
    } else {
        NSLog(@"邮箱格式不正确");
        return;
    }
    /*
    RCRegiseterAccountModel *model = [[RCRegiseterAccountModel alloc] init];
    model.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/Regi1.do";
    model.parameters = @{@"plat": @1, @"userid": @"LoginStepOneTest1", @"password": @"61709056", @"countryid": @"CN", @"cityid": @"1", @"lon": @50.0, @"lat": @50.0, @"pushtoken": @"123"};
    model.modelRequestMethod = kRCModelRequestMethodTypePOST;
    [model requestServerWithModel:model success:^(id resultModel) {
        NSLog(@"%@", resultModel);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    */
    
    
    
}

//邮箱正则
- (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
