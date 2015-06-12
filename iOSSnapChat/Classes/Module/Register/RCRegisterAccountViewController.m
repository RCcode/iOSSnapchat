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
    
    [self inheritSetting];
    [self acquireLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Utility
//设置继承属性
- (void)inheritSetting {
    self.arrowTitle = kRCLocalizedString(@"RegisterAccountSignUp");
    self.nextButtonText = @"Confirm";
    self.showForegetPassword = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

//获取本地地址
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
//confirm事件
- (void)nextButtonDidClicked {
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
//    NSLog(@"lon = %f lat = %f", _longitude, _latitude);
    
    /*
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    [revGeo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error && [placemarks count] > 0) {
            NSDictionary *dict = [[placemarks objectAtIndex:0] addressDictionary];
            NSLog(@"dict = %@", dict);
            NSLog(@"%@", [dict objectForKey:@"Street"]);
        } else {
            NSLog(@"erro");
        }
    }];
    */
     
    [_locationManager stopUpdatingLocation];
}

@end
