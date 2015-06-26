//
//  RCLoginViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/12.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCLoginViewController.h"
#import "RCLoginForgetPasswordViewController.h"
#import "RCBaseNavgationController.h"
#import "RCUserInfoModel.h"
#import "RCLoginAutoModel.h"
#import "RCLoginNormalModel.h"
#import "RCMainLikeViewController.h"

@interface RCLoginViewController ()

@end

@implementation RCLoginViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self inheritSetting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.isLogout) {
        return;
    }
    [RCMBHUDTool showIndicator];
    kAcquireUserDefaultAll
    
    //自动登录
    RCLoginAutoModel *loginAutoModel = [[RCLoginAutoModel alloc] init];
    loginAutoModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/AutoLogin.do";
    loginAutoModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    loginAutoModel.parameters = @{@"plat": @1,
                                  @"usertoken": usertoken,
                                  @"countryid": coutryID,
                                  @"cityid": cityID,
                                  @"lon": @(longitude),
                                  @"lat": @(latitude),
                                  @"pushtoken": pushtoken
                                  };
    
    [loginAutoModel requestServerWithModel:loginAutoModel success:^(id resultModel) {
        RCLoginAutoModel *result = (RCLoginAutoModel *)resultModel;
        if ([result.mess isEqualToString:@"succ"]) {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:@"自动登录完成" hideDelay:1];
            [self enterApplicationMain:result.userInfo];
        } else {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:@"usertoken过期/连接超时,请手动登陆" hideDelay:1];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Utility
//设置继承属性
- (void)inheritSetting {
    self.arrowTitle = @"Log In";
    self.nextButtonText = @"Log In";
    self.showForgetPassword = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Action
- (void)nextButtonDidClicked {

    kAcquireUserDefaultLocalInfo
    RCLoginNormalModel *loginNormalModel = [[RCLoginNormalModel alloc] init];
    loginNormalModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/Login.do";
    loginNormalModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    loginNormalModel.parameters = @{@"plat": @1,
                                    @"userid": self.emailField.text,
                                    @"password": self.passwordField.text,
                                    @"countryid": coutryID,
                                    @"cityid": cityID,
                                    @"lon": @(longitude),
                                    @"lat": @(latitude),
                                    @"pushtoken": pushtoken
                                    };
    
    [RCMBHUDTool showIndicator];
    [loginNormalModel requestServerWithModel:loginNormalModel success:^(id resultModel) {
        RCLoginNormalModel *result = (RCLoginNormalModel *)resultModel;
        if ([result.mess isEqualToString:@"succ"]) {
            [userDefault setObject:result.usertoken forKey:kRCUserDefaultUserTokenKey];
            [userDefault setInteger:0 forKey:kRCUserDefaultResgisterStepKey];
            [RCMBHUDTool hideshowIndicator];
            [self enterApplicationMain:result.userInfo];
        } else {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:@"账号或密码错误" hideDelay:1];
        }
    } failure:^(NSError *error) {
        [RCMBHUDTool hideshowIndicator];
        [RCMBHUDTool showText:@"请检查网络" hideDelay:1.0f];
    }];
}

- (void)forgetPasswordButtonDidClicked {
    RCLoginForgetPasswordViewController *loginForgetPasswordVc = [[RCLoginForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:loginForgetPasswordVc animated:YES];
}

- (void)enterApplicationMain:(RCUserInfoModel *)userInfo {
    RCMainLikeViewController *mainLikeVc = [[RCMainLikeViewController alloc] init];
    mainLikeVc.loginUserInfo = userInfo;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainLikeVc];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
