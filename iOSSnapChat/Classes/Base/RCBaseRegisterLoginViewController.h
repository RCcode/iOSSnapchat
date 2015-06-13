//
//  RCBaseRegisterLoginViewController.h
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/12.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCBaseArrowViewController.h"

@interface RCBaseRegisterLoginViewController : RCBaseArrowViewController

//设置next按钮文本(默认为为Default)
@property (nonatomic, copy) NSString *nextButtonText;
//设置是否显示忘记密码(默认为NO)
@property (nonatomic, assign, getter=isShowForgetPassword) BOOL showForgetPassword;
//获取自定义TextFiled内容
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UITextField *passwordField;
//Next按钮响应事件(重写)
- (void)nextButtonDidClicked;
//忘记密码按钮响应事件(重写)
- (void)forgetPasswordButtonDidClicked;

@end
