//
//  RCMBHUDTool.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/15.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMBHUDTool.h"
#import "MBProgressHUD.h"

@implementation RCMBHUDTool

+ (void)showText:(NSString *)text hideDelay:(NSTimeInterval)second {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.labelText = text;
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:second];
}

+ (void)showIndicator {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
}

+ (void)hideshowIndicator {
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

@end
