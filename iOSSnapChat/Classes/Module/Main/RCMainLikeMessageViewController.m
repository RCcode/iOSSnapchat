//
//  RCMainLikeMessageViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/24.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeMessageViewController.h"
#import "RCMainLikeMessageModel.h"
#import "RCMainMessageUserInfoModel.h"
#import "RCUserInfoModel.h"
#import "RCMainLikeMessageTableViewCell.h"
#import "RCMainLikeLikeYouViewController.h"
#import "RCMainLikeMatchYouViewController.h"

//主界面约束
#define kRCMainLikeMessageTableViewTopConstant 0
#define kRCMainLikeMessageTableViewBottomConstant 0
#define kRCMainLikeMessageTableViewLeftConstant 0
#define kRCMainLikeMessageTableViewRightConstant 0

typedef NS_ENUM(NSInteger, kRCMainLikeMessageType) {
    kRCMainLikeMessageTypeLike = 1,
    kRCMainLikeMessageTypeMatch
};

#define kRCMainLikeMessageTableViewCellReuseIdentifier @"kRCMainLikeMessageTableViewCellReuseIdentifier"

@interface RCMainLikeMessageViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
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
    [self addConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility
- (void)navgationSettings {
    self.title = @"Message";
    
    RCNavgationItemButton *categoryButton = [[RCNavgationItemButton alloc] init];
    categoryButton.frame = kRCDefaultNacgationBarItemFrame;
    [categoryButton setImage:kRCImage(@"other_icon") forState:UIControlStateNormal];
    [categoryButton addTarget:self action:@selector(categoryButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *categoryButtonItem = [[UIBarButtonItem alloc] initWithCustomView:categoryButton];
    self.navigationItem.rightBarButtonItem = categoryButtonItem;
}

- (void)loadData {
    RCMainLikeMessageModel *messageModel = [[RCMainLikeMessageModel alloc] init];
    kAcquireUserDefaultUsertoken
    int flag = [userDefault integerForKey:kRCUserDefaultCategoryKey];
    messageModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/message/getLikeUser.do";
    messageModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    messageModel.parameters = @{@"plat": @1,
                                @"usertoken": usertoken,
                                @"flag": @(flag),
                                @"pageno": @1
                                };
    [messageModel requestServerWithModel:messageModel success:^(id resultModel) {
        RCMainLikeMessageModel *result = (RCMainLikeMessageModel *)resultModel;
        _list = result.list;
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setUpUI {
    UITableView *tableView = [[UITableView alloc] init];
    [tableView registerClass:[RCMainLikeMessageTableViewCell class] forCellReuseIdentifier:kRCMainLikeMessageTableViewCellReuseIdentifier];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

- (void)addConstraint {
    [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCMainLikeMessageTableViewTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeMessageTableViewBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeMessageTableViewLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeMessageTableViewRightConstant]];
}

- (NSString *)acquireDateFormTimesp:(long long)timesp {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timesp / 1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-dd";
    return [formatter stringFromDate:confromTimesp];
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)categoryButtonDidClick {
    UIAlertController *categoryAlertVc = [[UIAlertController alloc] init];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    UIAlertAction *allAction = [UIAlertAction actionWithTitle:@"ALL" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [userDefault setInteger:2 forKey:kRCUserDefaultCategoryKey];
        [self loadData];
        [_tableView reloadData];
    }];
    
    UIAlertAction *matchAction = [UIAlertAction actionWithTitle:@"Match" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [userDefault setInteger:1 forKey:kRCUserDefaultCategoryKey];
        [self loadData];
        [_tableView reloadData];
    }];
    
    UIAlertAction *likeAction = [UIAlertAction actionWithTitle:@"Like" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [userDefault setInteger:0 forKey:kRCUserDefaultCategoryKey];
        [self loadData];
        [_tableView reloadData];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [categoryAlertVc addAction:allAction];
    [categoryAlertVc addAction:matchAction];
    [categoryAlertVc addAction:likeAction];
    [categoryAlertVc addAction:cancelAction];
    [self presentViewController:categoryAlertVc animated:YES completion:nil];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCMainLikeMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRCMainLikeMessageTableViewCellReuseIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RCMainMessageUserInfoModel *messageUserInfo = _list[indexPath.row];
    RCUserInfoModel *userInfo = messageUserInfo.userinfo;
    cell.showIconURL = [NSURL URLWithString:userInfo.url1];
    cell.showTitle = ([messageUserInfo.flag intValue] == kRCMainLikeMessageTypeLike) ? [NSString stringWithFormat:@"Like you on %@", [self acquireDateFormTimesp:[messageUserInfo.date_time longLongValue]]] : [NSString stringWithFormat:@"Match you on %@", [self acquireDateFormTimesp:[messageUserInfo.date_time longLongValue]]];
    cell.showLabel.textColor = ([messageUserInfo.flag intValue] == kRCMainLikeMessageTypeLike) ? kRCDefaultAlphaBlack : kRCDefaultDarkAlphaBlack;
    cell.isMore = ([messageUserInfo.flag intValue] == kRCMainLikeMessageTypeLike) ? NO : YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RCMainMessageUserInfoModel *messageUserInfo = _list[indexPath.row];
    RCUserInfoModel *userInfo = messageUserInfo.userinfo;
    if ([messageUserInfo.flag intValue] == kRCMainLikeMessageTypeLike) {
        //Like
        RCMainLikeLikeYouViewController *mainLikeLikeYouVc = [[RCMainLikeLikeYouViewController alloc] init];
        mainLikeLikeYouVc.iconURL = [NSURL URLWithString:userInfo.url1];
        mainLikeLikeYouVc.userid = messageUserInfo.userid1;
        [self.navigationController pushViewController:mainLikeLikeYouVc animated:YES];
    } else if ([messageUserInfo.flag intValue] == kRCMainLikeMessageTypeMatch) {
        //Match
        RCMainLikeMatchYouViewController *mainLikeMatchYouVc = [[RCMainLikeMatchYouViewController alloc] init];
        mainLikeMatchYouVc.iconURLMe = [NSURL URLWithString:self.userInfo.url1];
        mainLikeMatchYouVc.iconURLOhter = [NSURL URLWithString:userInfo.url1];
        mainLikeMatchYouVc.snapchatid = userInfo.snapchatid;
        [self.navigationController pushViewController:mainLikeMatchYouVc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRCAdaptationHeight(100);
}

@end
