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
#import "RCSearchSnaperViewController.h"

#import "RCLoginNormalModel.h"

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
//    NSLog(@"email = %@ password = %@", self.emailField.text, self.passwordField.text);
    
    kAcquireUserDefaultLocalInfo
    
    RCLoginNormalModel *loginUserInfoModel = [[RCLoginNormalModel alloc] init];
    loginUserInfoModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/Login.do";
    loginUserInfoModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    loginUserInfoModel.parameters = @{@"plat": @1,
                                      @"userid": self.emailField.text,
                                      @"password": self.passwordField.text,
                                      @"countryid": coutryID,
                                      @"cityid": cityID,
                                      @"lon": @(longitude),
                                      @"lat": @(latitude),
                                      @"pushtoken": pushtoken
                                      };
    [loginUserInfoModel requestServerWithModel:loginUserInfoModel success:^(id resultModel) {
        NSLog(@"%@", resultModel);
        
        
    } failure:^(NSError *error) {
        NSLog(@"error");
    }];
    
    return;
    RCSearchSnaperViewController *searchSnaperVc = [[RCSearchSnaperViewController alloc] init];
    RCBaseNavgationController *navVc = [[RCBaseNavgationController alloc] initWithRootViewController:searchSnaperVc];
    [self presentViewController:navVc animated:YES completion:nil];

}

- (void)forgetPasswordButtonDidClicked {
    RCLoginForgetPasswordViewController *loginForgetPasswordVc = [[RCLoginForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:loginForgetPasswordVc animated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
