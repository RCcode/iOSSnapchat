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

@interface RCRegisterAccountViewController ()
{
    BOOL _keyboardShow;
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
    [[RCLocalTool shareManager] acquireLocation];
}

#pragma mark - Utility
- (void)inheritSetting {
    self.nextButtonText = kRCLocalizedString(@"LoginRegisterButtonTitle");
    self.title = kRCLocalizedString(@"RegisterAccountNavigationRegisterTitle");
    self.showForgetPassword = NO;
}

#pragma mark - Action
- (void)nextButtonDidClicked {
    //判断邮箱密码是否为空
    if ([self.emailField.text isEqualToString:@""]) {
        [RCMBHUDTool showText:kRCLocalizedString(@"RegisterAccountEmailErrorMessage") hideDelay:1.0f];
        return;
    } else if ([self.passwordField.text isEqualToString:@""]) {
        [RCMBHUDTool showText:kRCLocalizedString(@"RegisterAccountPasswordErrorMessage") hideDelay:1.0f];
        return;
    }
    kAcquireUserDefaultLocalInfo
    RCRegiseterAccountModel *registerAccountModel = [[RCRegiseterAccountModel alloc] init];
    registerAccountModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    registerAccountModel.requestUrl = [Global shareGlobal].registerAccountURLString;
    registerAccountModel.parameters = @{@"plat": @1,
                                        @"userid": self.emailField.text,
                                        @"password": self.passwordField.text,
                                        @"countryid": coutryID,
                                        @"cityid": cityID,
                                        @"lon": @(longitude),
                                        @"lat": @(latitude),
                                        @"pushtoken": pushtoken
                                        };
    if ([self validateEmail:self.emailField.text]) {
        [RCMBHUDTool showIndicator];
        [registerAccountModel requestServerWithModel:registerAccountModel success:^(id resultModel) {
            RCRegiseterAccountModel *result = (RCRegiseterAccountModel *)resultModel;
            if ([result.state intValue] == 10000) {
                [RCMBHUDTool hideshowIndicator];
                [RCMBHUDTool showText:kRCLocalizedString(@"RegisterAccountSetpUpUserErrorCodeRepeatAccount") hideDelay:1.0f];
                [[NSUserDefaults standardUserDefaults] setObject:result.usertoken forKey:kRCUserDefaultUserTokenKey];
                RCRegisterInfoViewController *registerInfoVc = [[RCRegisterInfoViewController alloc] init];
                [self.navigationController pushViewController:registerInfoVc animated:YES];
            } else if ([result.state intValue] == 10003) {
                [RCMBHUDTool hideshowIndicator];
                [RCMBHUDTool showText:kRCLocalizedString(@"RegisterAccountSetpUpUserErrorCodeUsertokenError") hideDelay:1.0f];
            } else {
                [RCMBHUDTool hideshowIndicator];
                [RCMBHUDTool showText:kRCLocalizedString(@"RegisterAccountSetpUpUserErrorCodeCannotConnectServer") hideDelay:1.0f];
            }
        } failure:^(NSError *error) {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:kRCLocalizedString(@"RegisterAccountSetpUpUserErrorCodeNetworkError") hideDelay:1.0f];
        }];
    } else {
        [RCMBHUDTool showText:kRCLocalizedString(@"RegisterAccountEmailFormatErrorMessage") hideDelay:1.0f];
    }
}

- (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
