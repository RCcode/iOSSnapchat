//
//  AppDelegate.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/8.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "AppDelegate.h"
#import "RCHomeViewController.h"
#import "RCBaseNavgationController.h"
#import "RCRegisterAccountViewController.h"
#import "RCRegisterInfoViewController.h"
#import "RCRegisterUploadViewController.h"
#import "RCLoginViewController.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

#define kRCParsePushApplicationId @"6pwRJKt4anhU2GH4K0NGmliEfi5urYo0HJpouBNI"
#define kRCParsePushClientKey @"6Yr58PV4U7nRkGvJUyI5id3634UTxv8IWoqQ5mHf"


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:kRCParsePushApplicationId clientKey:kRCParsePushClientKey];
    [self handleNotificationWithInfo:[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]];
    
    if(IOS8){
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes  categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self addNotification];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kRCUserDefaultUserTokenKey] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"defaultUsertoken" forKey:kRCUserDefaultUserTokenKey];
    }
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kRCApplicationFirstStartKey]) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setBool:YES forKey:kRCApplicationFirstStartKey];
        [userDefault setObject:@"000000" forKey:kRCRemoteNotificationsKey];
        [userDefault setInteger:-1 forKey:kRCUserDefaultResgisterStepKey];
        [userDefault setObject:@"" forKey:kRCUserDefaultCountryIDKey];
        [userDefault setObject:@"" forKey:kRCUserDefaultCityIDKey];
        [userDefault setDouble:0 forKey:kRCUserDefaultLongitudeKey];
        [userDefault setDouble:0 forKey:kRCUserDefaultLatitudeKey];
        [userDefault setInteger:-1 forKey:kRCUserDefaultGenderKey];
        [[NSNotificationCenter defaultCenter] postNotificationName:kRCSwitchRootVcNotification object:nil userInfo:@{kRCSwitchRootVcNotificationStepKey: @(-2)}];
    } else {
        NSInteger step = [[NSUserDefaults standardUserDefaults] integerForKey:kRCUserDefaultResgisterStepKey];
        [[NSNotificationCenter defaultCenter] postNotificationName:kRCSwitchRootVcNotification object:nil userInfo:@{kRCSwitchRootVcNotificationStepKey: @(step)}];
    }
    return YES;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToRootVc:) name:kRCSwitchRootVcNotification object:nil];
}

//kRCSwitchRootVcNotificationVcKey 传入Animation = YES,不传入Animation = NO
- (void)switchToRootVc:(NSNotification *)notice {
    NSInteger step = [notice.userInfo[kRCSwitchRootVcNotificationStepKey] integerValue];
    RCBaseNavgationController *navVc = nil;
    switch (step) {
        case -2:
        {
            if (!notice.userInfo[kRCSwitchRootVcNotificationVcKey]) {
                UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
                layout.itemSize = kRCScreenBounds.size;
                layout.minimumLineSpacing = 0;
                layout.minimumInteritemSpacing = 0;
                layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
                RCHomeViewController *homeVc = [[RCHomeViewController alloc] init];
                self.window.rootViewController = homeVc;
                [self.window makeKeyAndVisible];
            } else {
                //登出，返回首页arrow自定义动画
                UIViewController *sendVcNav = notice.userInfo[kRCSwitchRootVcNotificationVcKey];
                RCHomeViewController *homeVc = [[RCHomeViewController alloc] init];
                homeVc.view.frame = CGRectMake(0, 0, kRCScreenWidth, kRCScreenHeight);
                [[UIApplication sharedApplication].keyWindow addSubview:homeVc.view];
                [[UIApplication sharedApplication].keyWindow sendSubviewToBack:homeVc.view];
                [UIView animateWithDuration:0.2f animations:^{
                    sendVcNav.view.frame = CGRectMake(0, kRCScreenHeight, kRCScreenWidth, kRCScreenHeight);
                } completion:^(BOOL finished) {
                    //销毁传入控制器控制器
                    for (UIViewController *sendVc in sendVcNav.childViewControllers) {
                        [sendVc removeFromParentViewController];
                    }
                    //销毁传入控制器视图
                    [sendVcNav.view removeFromSuperview];
                    self.window.rootViewController = homeVc;
                    [self.window makeKeyAndVisible];
                }];
            }
            return;
        }
        case -1:
        {
            RCRegisterAccountViewController *registerAccountVc = [[RCRegisterAccountViewController alloc] init];
            navVc = [[RCBaseNavgationController alloc] initWithRootViewController:registerAccountVc];
            break;
        }
        case 1:
        {
            RCRegisterInfoViewController *registerInfoVc = [[RCRegisterInfoViewController alloc] init];
            navVc = [[RCBaseNavgationController alloc] initWithRootViewController:registerInfoVc];
            break;
        }
        case 2:
        {
            RCRegisterUploadViewController *registerUploadVc = [[RCRegisterUploadViewController alloc] init];
            navVc = [[RCBaseNavgationController alloc] initWithRootViewController:registerUploadVc];
            break;
        }
        case 0:
        {
            if (!notice.userInfo[kRCSwitchRootVcNotificationVcKey]) {
                RCLoginViewController *loginVc = [[RCLoginViewController alloc] init];
                loginVc.isAutoLogin = YES;
                navVc = [[RCBaseNavgationController alloc] initWithRootViewController:loginVc];
                self.window.rootViewController = navVc;
                [self.window makeKeyAndVisible];
            } else {
                //手动登录按钮点击自定义动画
                UIViewController *sendVcNav = notice.userInfo[kRCSwitchRootVcNotificationVcKey];
                RCLoginViewController *loginVc = [[RCLoginViewController alloc] init];
                loginVc.view.frame = CGRectMake(kRCScreenWidth, 64, kRCScreenWidth, kRCScreenHeight - 64);
                navVc = [[RCBaseNavgationController alloc] initWithRootViewController:loginVc];
                [[UIApplication sharedApplication].keyWindow addSubview:loginVc.view];
                [[UIApplication sharedApplication].keyWindow bringSubviewToFront:loginVc.view];
                sendVcNav.title = kRCLocalizedString(@"RegisterAccountNavigationLoginTitle");
                [UIView animateWithDuration:0.2f animations:^{
                    loginVc.view.frame = CGRectMake(0, 64, kRCScreenWidth, kRCScreenHeight - 64);
                } completion:^(BOOL finished) {
                    //销毁传入控制器控制器
                    for (UIViewController *sendVc in sendVcNav.childViewControllers) {
                        [sendVc removeFromParentViewController];
                    }
                    //销毁传入控制器视图
                    [sendVcNav.view removeFromSuperview];
                    
                    self.window.rootViewController = navVc;
                    [self.window makeKeyAndVisible];
                }];
            }
            return;
        }
        default:
            break;
    }
    self.window.rootViewController = navVc;
    [self.window makeKeyAndVisible];
    NSLog(@"Root Step = %d", step);
}

//只支持竖屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@",[deviceToken description]);
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
    [[NSUserDefaults standardUserDefaults] setObject:currentInstallation.deviceToken forKey:kRCRemoteNotificationsKey];
    [PFPush subscribeToChannelInBackground:@"" block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"ParseStarterProject successfully subscribed to push notifications on the broadcast channel.");
        } else {
            NSLog(@"ParseStarterProject failed to subscribe to push notifications on the broadcast channel.");
        }
    }];
    
    NSLog(@"%@", currentInstallation.deviceToken);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
    [self handleNotificationWithInfo:userInfo];
}

- (void)handleNotificationWithInfo:(NSDictionary *)userInfo {
    [self cancelNotification];
    if(userInfo == nil) return;
    
    //处理通知
    NSLog(@"%@", userInfo);
}

- (void)cancelNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
