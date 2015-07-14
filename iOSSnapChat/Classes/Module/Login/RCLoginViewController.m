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
#import "RCRegisterInfoViewController.h"
#import "RCRegisterUploadViewController.h"

@interface RCLoginViewController () <UITextFieldDelegate>

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
    if (!self.isAutoLogin) return;
    //自动登录
    kAcquireUserDefaultAll
    RCLoginAutoModel *loginAutoModel = [[RCLoginAutoModel alloc] init];
    loginAutoModel.requestUrl = [Global shareGlobal].loginAutoLoginURLString;
    loginAutoModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    loginAutoModel.parameters = @{@"plat": @1,
                                  @"usertoken": usertoken,
                                  @"countryid": coutryID,
                                  @"cityid": cityID,
                                  @"lon": @(longitude),
                                  @"lat": @(latitude),
                                  @"pushtoken": pushtoken
                                  };
    [RCMBHUDTool showIndicator];
    [loginAutoModel requestServerWithModel:loginAutoModel success:^(id resultModel) {
        RCLoginAutoModel *result = (RCLoginAutoModel *)resultModel;
        if ([result.state intValue] == 10000) {
            [RCMBHUDTool hideshowIndicator];
            if ([result.step intValue] != 0) {
                [RCMBHUDTool showText:kRCLocalizedString(@"LoginAutoLoginStepLoginMess") hideDelay:1];
                return;
            }
            [RCMBHUDTool showText:kRCLocalizedString(@"LoginAutoLoginErrorCodeSucc") hideDelay:1];
            [self enterApplicationMain:result.userInfo];
        } else if ([result.state intValue] == 10004) {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:kRCLocalizedString(@"LoginAutoLoginErrorCodeUsertokenError") hideDelay:1];
        } else if ([result.state intValue] == 10009) {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:kRCLocalizedString(@"LoginAutoLoginErrorCodeAccountLock") hideDelay:1];
        } else {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:kRCLocalizedString(@"LoginAutoLoginErrorCodeCannotConnectServer") hideDelay:1];
        }
    } failure:^(NSError *error) {
        [RCMBHUDTool hideshowIndicator];
        [RCMBHUDTool showText:kRCLocalizedString(@"LoginAutoLoginErrorCodeNetworkError") hideDelay:1];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Utility
- (void)inheritSetting {
    self.arrowTitle = kRCLocalizedString(@"NULL");
    self.nextButtonText = kRCLocalizedString(@"LoginLoginButtonTitle");
    self.title = kRCLocalizedString(@"RegisterAccountNavigationLoginTitle");
    self.showForgetPassword = YES;
    self.nextButton.enabled = NO;
    self.emailField.delegate = self;
    self.passwordField.delegate = self;
}

#pragma mark - Action
- (void)nextButtonDidClicked {
    kAcquireUserDefaultLocalInfo
    RCLoginNormalModel *loginNormalModel = [[RCLoginNormalModel alloc] init];
    loginNormalModel.requestUrl = [Global shareGlobal].loginnormalLoginURLString;
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
        if ([result.state intValue] == 10000) {
            [RCMBHUDTool hideshowIndicator];
            if ([result.step intValue] != 0) {
                [userDefault setObject:result.usertoken forKey:kRCUserDefaultUserTokenKey];
                if ([result.step intValue] == 1) {
                    RCRegisterInfoViewController *registerInfoVc = [[RCRegisterInfoViewController alloc] init];
                    [self.navigationController pushViewController:registerInfoVc animated:YES];
                }
                if ([result.step intValue] == 2) {
                    RCRegisterUploadViewController *registerUploadVc = [[RCRegisterUploadViewController alloc] init];
                    [self.navigationController pushViewController:registerUploadVc animated:YES];
                }
                return;
            }
            [RCMBHUDTool showText:kRCLocalizedString(@"LoginNormalLoginErrorCodeSucc") hideDelay:1.0f];
            [userDefault setObject:result.usertoken forKey:kRCUserDefaultUserTokenKey];
            [self enterApplicationMain:result.userInfo];
        } else if ([result.state intValue] == 10005) {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:kRCLocalizedString(@"LoginNormalLoginErrorCodeAccountPasswordError") hideDelay:1.0f];
        } else if ([result.state intValue] == 10009) {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:kRCLocalizedString(@"LoginNormalLoginErrorCodeAccountLock") hideDelay:1.0f];
        } else {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:kRCLocalizedString(@"LoginNormalLoginErrorCodeCannotConnectServer") hideDelay:1.0f];
        }
    } failure:^(NSError *error) {
        [RCMBHUDTool hideshowIndicator];
        [RCMBHUDTool showText:kRCLocalizedString(@"LoginNormalLoginErrorCodeNetworkError") hideDelay:1.0f];
    }];
}

- (void)forgetPasswordButtonDidClicked {
    RCLoginForgetPasswordViewController *loginForgetPasswordVc = [[RCLoginForgetPasswordViewController alloc] init];
    loginForgetPasswordVc.popVc = self;
    [self.navigationController pushViewController:loginForgetPasswordVc animated:YES];
}

- (void)enterApplicationMain:(RCUserInfoModel *)userInfo {
    RCMainLikeViewController *mainLikeVc = [[RCMainLikeViewController alloc] init];
    mainLikeVc.loginUserInfo = userInfo;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainLikeVc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.emailField) {
        self.nextButton.enabled = ((string.length == 0 && textField.text.length > 1 && self.passwordField.text.length > 0) || (string.length > 0 && self.passwordField.text.length > 0))  ? YES : NO;
    } else if (textField == self.passwordField) {
        self.nextButton.enabled = ((string.length == 0 && textField.text.length > 1 && self.emailField.text.length > 0) || (string.length > 0 && self.emailField.text.length > 0))  ? YES : NO;
    }
    return YES;
}

@end
