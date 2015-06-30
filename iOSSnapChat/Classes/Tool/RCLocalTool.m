//
//  RCLocalTool.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/15.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCLocalTool.h"
#import <CoreLocation/CoreLocation.h>

@interface RCLocalTool () <CLLocationManagerDelegate>
{
    CLGeocoder *_revGeocoder;
}

@end

@implementation RCLocalTool

static id _manager;
static CLLocationManager *_instance;

+ (instancetype)shareManager {
    CLLocationManager *instance = [[CLLocationManager alloc] init];
    instance.desiredAccuracy = kCLLocationAccuracyBest;
    instance.distanceFilter = kCLDistanceFilterNone;
    if (IOS8) [instance requestAlwaysAuthorization];
    _instance = instance;
    _manager = [[self alloc] init];
    return _manager;
}

//获取本地地址
- (void)acquireLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        _instance.delegate = self;
        [_instance startUpdatingLocation];
    } else {
        NSLog(@"无法获取当前地址");
    }
}

#pragma mark - <CLLocationManagerDelegate>
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [_instance stopUpdatingLocation];
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
            NSLog(@"地理编码失败, %@", error);
        }
    }];
    _revGeocoder = revGeocoder;
}

@end
