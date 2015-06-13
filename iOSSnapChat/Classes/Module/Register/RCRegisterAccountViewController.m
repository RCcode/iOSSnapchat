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
#import "RCRegisterAccountViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface RCRegisterAccountViewController () <CLLocationManagerDelegate>
{
    BOOL _keyboardShow;
    CLLocationManager *_locationManager;
}

@end

@implementation RCRegisterAccountViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self inheritSetting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self acquireLocation];
}

#pragma mark - Utility
//设置继承属性
- (void)inheritSetting {
    self.arrowTitle = kRCLocalizedString(@"RegisterAccountSignUp");
    self.nextButtonText = @"Confirm";
    self.showForgetPassword = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

//获取本地地址
- (void)acquireLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        CLLocationManager *manager = [[CLLocationManager alloc] init];
        manager.desiredAccuracy = kCLLocationAccuracyBest;
        manager.distanceFilter = kCLDistanceFilterNone;
        manager.delegate = self;
        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) [manager requestAlwaysAuthorization];
        [manager startUpdatingLocation];
        _locationManager = manager;
    } else {
        NSLog(@"无法获取当前地址");
    }
}

#pragma mark - Action
//confirm事件
- (void)nextButtonDidClicked {

    //判断邮箱密码是否为空
    if ([self.emailField.text isEqualToString:@""]) {
        return;
    } else if ([self.passwordField.text isEqualToString:@""]) {
        return;
    }
    
    //获取请求信息
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *coutryID = [userDefault stringForKey:kRCUserDefaultCountryIDKey];
    NSString *cityID = [userDefault stringForKey:kRCUserDefaultCityIDKey];
    double longitude = [userDefault doubleForKey:kRCUserDefaultLongitudeKey];
    double latitude = [userDefault doubleForKey:kRCUserDefaultLatitudeKey];
    
    //请求设置
    RCRegiseterAccountModel *registerAccountModel = [[RCRegiseterAccountModel alloc] init];
    registerAccountModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    registerAccountModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/Regi1.do";
    registerAccountModel.parameters = @{@"plat": @1,
                                        @"userid": self.emailField.text,
                                        @"password": self.passwordField.text,
                                        @"countryid": coutryID,
                                        @"cityid": cityID,
                                        @"lon": @(longitude),
                                        @"lat": @(latitude),
                                        @"pushtoken": @"123"
                                        };
 
    //判断邮箱是否正确
    if ([self validateEmail:self.emailField.text]) {
        //发送请求
        [registerAccountModel requestServerWithModel:registerAccountModel success:^(id resultModel) {
            RCRegiseterAccountModel *result = (RCRegiseterAccountModel *)resultModel;
            RCRegisterInfoViewController *registerInfoVc = [[RCRegisterInfoViewController alloc] init];
            registerInfoVc.usertoken = result.usertoken;
            [self.navigationController pushViewController:registerInfoVc animated:YES];
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    } else {
        NSLog(@"邮箱格式不正确");
    }
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
    [_locationManager stopUpdatingLocation];
    
    //保存定位信息
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //经度
    CLLocation *location = [locations lastObject];
    double longitude = location.coordinate.longitude;
    [userDefault setDouble:longitude forKey:kRCUserDefaultLongitudeKey];
    //纬度
    double latitude = location.coordinate.latitude;
    [userDefault setDouble:latitude forKey:kRCUserDefaultLatitudeKey];
    //国家ID
    NSString *fullCountryInfo = [NSLocale currentLocale].localeIdentifier;
    NSString *coutryID = [fullCountryInfo substringFromIndex:fullCountryInfo.length - 2];
    [userDefault setObject:coutryID forKey:kRCUserDefaultCountryIDKey];
    //cityId
    CLGeocoder *revGeocoder = [[CLGeocoder alloc] init];
    [revGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error && [placemarks count] > 0) {
            NSDictionary *dict = [[placemarks objectAtIndex:0] addressDictionary];
            NSString *cityID = [dict objectForKey:@"City"];
            [userDefault setObject:cityID forKey:kRCUserDefaultCityIDKey];
        } else {
            NSLog(@"地理编码失败");
        }
    }];
}

@end
