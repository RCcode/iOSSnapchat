//
//  RCMainLikeMessageViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/24.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeMessageViewController.h"
#import "RCMainLikeMessageModel.h"
#import "RCMainMessageUserInfo.h"
#import "RCUserInfoModel.h"

@interface RCMainLikeMessageViewController ()
{
    NSArray *_list;
}

@end

@implementation RCMainLikeMessageViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self navgationSettings];
    [self loadData];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility

- (void)navgationSettings {
    
#warning 修改leftitem
    self.title = @"Message";
    self.view.backgroundColor = [UIColor whiteColor];
    //Report
    UIButton *categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    categoryButton.frame = CGRectMake(0, 0, 44, 44);
    [categoryButton setTitle:@"..." forState:UIControlStateNormal];
    [categoryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [categoryButton addTarget:self action:@selector(categoryButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *categoryButtonItem = [[UIBarButtonItem alloc] initWithCustomView:categoryButton];
    self.navigationItem.rightBarButtonItem = categoryButtonItem;
}

- (void)loadData {
    RCMainLikeMessageModel *messageModel = [[RCMainLikeMessageModel alloc] init];
    kAcquireUserDefaultUsertoken
    messageModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/message/getLikeUser.do";
    messageModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    messageModel.parameters = @{@"plat": @1,
                                @"usertoken": usertoken,
                                @"flag": @0,
                                @"pageno": @1
                                };
    [messageModel requestServerWithModel:messageModel success:^(id resultModel) {
        RCMainLikeMessageModel *result = (RCMainLikeMessageModel *)resultModel;
        _list = result.list;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

- (void)setUpUI {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Action
- (void)categoryButtonDidClick {
    NSLog(@"Category");
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list.count;
}

/*
 RCMainLikeMessageModel *result = (RCMainLikeMessageModel *)resultModel;
 RCMainMessageUserInfo *messageUserInfo = result.list[0];
 RCUserInfoModel *userInfo = messageUserInfo.userinfo;
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    RCMainMessageUserInfo *messageUserInfo = _list[indexPath.row];
    RCUserInfoModel *userInfo = messageUserInfo.userinfo;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:userInfo.url1] placeholderImage:[UIImage imageNamed:@"default.jpg"]];
    return cell;
}


@end
