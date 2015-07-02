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
    
    //获取用户存储的物理地址信息
    kAcquireUserDefaultLocalInfo
    
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
                                        @"pushtoken": pushtoken
                                        };
    NSLog(@"%@", registerAccountModel.parameters);
    //判断邮箱是否正确
    if ([self validateEmail:self.emailField.text]) {
        //发送请求
        [RCMBHUDTool showIndicator];
        [registerAccountModel requestServerWithModel:registerAccountModel success:^(id resultModel) {
            RCRegiseterAccountModel *result = (RCRegiseterAccountModel *)resultModel;
            [userDefault setInteger:[result.step intValue] forKey:kRCUserDefaultResgisterStepKey];
            if ([result.mess isEqualToString:@"succ"]) {
                [RCMBHUDTool hideshowIndicator];
                //保存usertoken
                [[NSUserDefaults standardUserDefaults] setObject:result.usertoken forKey:kRCUserDefaultUserTokenKey];
                RCRegisterInfoViewController *registerInfoVc = [[RCRegisterInfoViewController alloc] init];
                [self.navigationController pushViewController:registerInfoVc animated:YES];
            } else if ([result.mess isEqualToString:@"Primary key repeat"]) {
                [RCMBHUDTool hideshowIndicator];
                [RCMBHUDTool showText:@"注册账户已经存在" hideDelay:1.0f];
            } else {
                NSLog(@"%d", [result.step intValue]);
                [RCMBHUDTool hideshowIndicator];
                [RCMBHUDTool showText:@"服务器异常" hideDelay:1.0f];
            }
        } failure:^(NSError *error) {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:@"请检查网络" hideDelay:1.0f];
        }];
    } else {
        [RCMBHUDTool showText:@"邮箱格式不正确" hideDelay:1.0f];
    }
}

- (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
