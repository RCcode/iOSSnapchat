//
//  RCRegisterAccountViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/9.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegisterAccountViewController.h"
#import "RCRegiseterAccountModel.h"
#import "RCRegisterInfoViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface RCRegisterAccountViewController () <CLLocationManagerDelegate>
{
    RCPlaceHolderAlwaysTextField *_emailField;
    RCPlaceHolderAlwaysTextField *_passwordField;
    BOOL _keyboardShow;
    CLLocationManager *_locationManager;
    CGFloat _longitude;
    CGFloat _latitude;
}

@end

@implementation RCRegisterAccountViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self acquireLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Utility
//创建子控件
- (void)setUpUI {
#warning Modify Frame/Number
    self.arrowTitle = kRCLocalizedString(@"SignUp");
    self.view.backgroundColor = [UIColor whiteColor];
    //邮箱
    RCPlaceHolderAlwaysTextField *emailField = [[RCPlaceHolderAlwaysTextField alloc] initWithFrame:CGRectMake(20, 84, kRCScreenWidth - 40, 44)];
    emailField.userPlaceHolder =  kRCLocalizedString(@"EmailAddress");
    [emailField addTarget:self action:@selector(keyBoardDidShow) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:emailField];
    _emailField = emailField;
    //邮箱分割线
    UIView *emailSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(emailField.frame), kRCScreenWidth, 1)];
    emailSeparatorLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:emailSeparatorLine];
    //密码
    RCPlaceHolderAlwaysTextField *passwordField = [[RCPlaceHolderAlwaysTextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(emailField.frame) + 20, kRCScreenWidth - 40, 44)];
    [passwordField addTarget:self action:@selector(keyBoardDidShow) forControlEvents:UIControlEventEditingDidBegin];
    passwordField.userPlaceHolder = kRCLocalizedString(@"Password");
    [self.view addSubview:passwordField];
    _passwordField = passwordField;
    //密码分割线
    UIView *passwordSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(passwordField.frame), kRCScreenWidth, 1)];
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

//获取本地物理地址
- (void)acquireLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        CLLocationManager *manager = [[CLLocationManager alloc] init];
        manager.desiredAccuracy = kCLLocationAccuracyBest;
        manager.delegate = self;
        if ([[UIDevice currentDevice].systemVersion doubleValue] > 8.0) [manager requestAlwaysAuthorization];
        [manager startUpdatingLocation];
        _locationManager = manager;
    } else {
        NSLog(@"无法获取当前地址");
    }
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
    RCRegisterInfoViewController *regsisterInfoVc = [[RCRegisterInfoViewController alloc] init];
    [self.navigationController pushViewController:regsisterInfoVc animated:YES];
    
    /*
    if ([self validateEmail:_emailField.text]) {
        if (_longitude && _latitude) {
            RCRegiseterAccountModel *model = [[RCRegiseterAccountModel alloc] init];
            model.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/Regi1.do";
            model.parameters = @{@"plat": @1, @"userid": _emailField.text, @"password": _passwordField.text, @"countryid": @"CN", @"cityid": @"1", @"lon": @(_longitude), @"lat": @(_latitude), @"pushtoken": @""};
            model.modelRequestMethod = kRCModelRequestMethodTypePOST;
            [model requestServerWithModel:model success:^(id resultModel) {
                NSLog(@"%@", resultModel);
            } failure:^(NSError *error) {
                NSLog(@"%@", error);
            }];
        }
    } else {
        NSLog(@"邮箱格式不正确");
        return;
    }
     */
}

//邮箱正则
- (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - <CLLocationManagerDelegate>
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
#warning block
    _longitude = location.coordinate.longitude;
    _latitude = location.coordinate.latitude;
    [_locationManager stopUpdatingLocation];
}

@end
