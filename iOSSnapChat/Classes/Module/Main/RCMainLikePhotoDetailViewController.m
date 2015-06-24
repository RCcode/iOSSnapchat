//
//  RCMainLikePhotoDetailViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/24.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikePhotoDetailViewController.h"
#import "RCMainInformModel.h"

@interface RCMainLikePhotoDetailViewController ()

@end

@implementation RCMainLikePhotoDetailViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%@", self.selectedUserInfo);
    
    [self inheritSetting];
    [self navgationSettings];
    [self setUpUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)inheritSetting {
    self.arrowTitle = @"";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)navgationSettings {
    //Report
    UIButton *informButton = [UIButton buttonWithType:UIButtonTypeCustom];
    informButton.frame = CGRectMake(0, 0, 44, 44);
    [informButton setTitle:@"rpt" forState:UIControlStateNormal];
    [informButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [informButton addTarget:self action:@selector(informButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *informButtonItem = [[UIBarButtonItem alloc] initWithCustomView:informButton];
    self.navigationItem.rightBarButtonItem = informButtonItem;
}

#pragma mark - Utility
- (void)setUpUI {
    
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)informButtonDidClick {
    //举报
    UIAlertController *informAlertVc = [[UIAlertController alloc] init];
    kAcquireUserDefaultUsertoken
    RCUserInfoModel *userInfo = self.selectedUserInfo;
    UIAlertAction *informAction = [UIAlertAction actionWithTitle:@"Inform" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        RCMainInformModel *informModel = [[RCMainInformModel alloc] init];
        informModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/ReportUsers.do";
        informModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
        informModel.parameters = @{@"plat": @1,
                                   @"usertoken": usertoken,
                                   @"userid": userInfo.userid
                                   };
        [informModel requestServerWithModel:informModel success:^(id resultModel) {
            RCMainInformModel *result = (RCMainInformModel *)resultModel;
            if ([result.mess isEqualToString:@"succ"]) {
                [RCMBHUDTool showText:@"举报成功" hideDelay:1];
            } else {
                NSLog(@"举报其他处理");
            }
        } failure:^(NSError *error) {
            NSLog(@"网络异常");
        }];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [informAlertVc addAction:informAction];
    [informAlertVc addAction:cancelAction];
    [self presentViewController:informAlertVc animated:YES completion:nil];
}

@end
