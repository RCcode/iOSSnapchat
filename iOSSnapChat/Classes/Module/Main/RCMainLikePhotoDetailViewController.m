//
//  RCMainLikePhotoDetailViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/24.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikePhotoDetailViewController.h"
#import "RCMainLikeInfoModel.h"
#import "RCMainLikeCollectionViewCell.h"

@interface RCMainLikePhotoDetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    UICollectionView *_likePhotoCollectionView;
    UIImageView *_sexImageView;
    UILabel *_ageLabel;
    UILabel *_distanceLabel;
    UILabel *_indexLabel;
}

@end

@implementation RCMainLikePhotoDetailViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self inheritSetting];
    [self navgationSettings];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_likePhotoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedItem inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

#pragma mark - Utility
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

- (void)setUpUI {
    //好友展示
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *likePhotoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 64, kRCScreenWidth - 40, kRCScreenWidth - 40) collectionViewLayout:layout];
    layout.itemSize = CGSizeMake(likePhotoCollectionView.frame.size.width, likePhotoCollectionView.frame.size.height);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    likePhotoCollectionView.pagingEnabled = YES;
    likePhotoCollectionView.showsHorizontalScrollIndicator = NO;
    [likePhotoCollectionView registerClass:[RCMainLikeCollectionViewCell class] forCellWithReuseIdentifier:@"test"];
    likePhotoCollectionView.dataSource = self;
    likePhotoCollectionView.delegate = self;
    [self.view addSubview:likePhotoCollectionView];
    _likePhotoCollectionView = likePhotoCollectionView;
    
    //indexLabel
    UILabel *indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRCScreenWidth - 20 - 40, kRCScreenWidth - 40 - 20 + 64, 40, 20)];
    indexLabel.text = [NSString stringWithFormat:@"%d/%d", self.selectedItem + 1, [self acquirePhotoCount:self.selectedUserInfo]];
    [self.view addSubview:indexLabel];
    _indexLabel = indexLabel;
    
    //Sex
    UIImageView *sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + 20, CGRectGetMaxY(likePhotoCollectionView.frame) + 20, 20, 20)];
    [self.view addSubview:sexImageView];
    _sexImageView = sexImageView;
    
    //Age
    UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(sexImageView.frame) + 10, CGRectGetMaxY(likePhotoCollectionView.frame) + 20, 20, 20)];
    ageLabel.text = [NSString stringWithFormat:@"%@", self.selectedUserInfo.age];
    [self.view addSubview:ageLabel];
    _ageLabel = ageLabel;
    
    //Distance
    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRCScreenWidth - 20 - 80 - 20, CGRectGetMaxY(likePhotoCollectionView.frame) + 20, 80, 20)];
    //获取距离
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    double userLongitude = [userDefault doubleForKey:kRCUserDefaultLongitudeKey];
    double userLatitude = [userDefault doubleForKey:kRCUserDefaultLatitudeKey];
    double choiceLongtitude = [self.selectedUserInfo.lon floatValue];
    double choiceLatitude = [self.selectedUserInfo.lat floatValue];
    NSString *distance = nil;
    if (userLongitude == 0 || userLatitude == 0 || choiceLongtitude == 100000 || choiceLatitude == 100000) {
        distance = @"NULL";
    } else {
        RCLocation fromLocation = {userLongitude, userLatitude};
        RCLocation toLocation = {choiceLongtitude, choiceLatitude};
        distance = [NSString stringWithFormat:@"%f m", [self distanceFromLocation:fromLocation toLocation:toLocation]];
    }
    
    distanceLabel.text = [NSString stringWithFormat:@"%@", distance];
    [self.view addSubview:distanceLabel];
    _distanceLabel = distanceLabel;
    
    //UnLike
    UIButton *unLikeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    unLikeButton.tag = kRCMainLikeTypeUnlike;
    unLikeButton.frame = CGRectMake((kRCScreenWidth - 120 - 20) / 2, CGRectGetMaxY(distanceLabel.frame) + 20, 60, 60);
    [unLikeButton setTitle:@"UnLike" forState:UIControlStateNormal];
    [unLikeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [unLikeButton addTarget:self action:@selector(choiceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:unLikeButton];
    
    //Like
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.tag = kRCMainLikeTypeLike;
    likeButton.frame = CGRectMake(CGRectGetMaxX(unLikeButton.frame) + 20, CGRectGetMaxY(distanceLabel.frame) + 20, 60, 60);
    [likeButton setTitle:@"Like" forState:UIControlStateNormal];
    [likeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [likeButton addTarget:self action:@selector(choiceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeButton];
}

- (NSInteger)acquirePhotoCount:(RCUserInfoModel *)userInfo {
    if (![userInfo.url3 isEqualToString:@""]) {
        return 3;
    } else if (![userInfo.url2 isEqualToString:@""]) {
        return 2;
    } else if (![userInfo.url1 isEqualToString:@""]) {
        return 1;
    } else {
        return 0;
    }
}

- (float)distanceFromLocation:(RCLocation)fromLocation toLocation:(RCLocation)toLocation {
    return sqrt(((fromLocation.longitude - toLocation.longitude) * M_PI * 12656 * cos(((fromLocation.latitude + toLocation.latitude) / 2) * M_PI / 180) / 180 *
                 (fromLocation.longitude - toLocation.longitude) * M_PI * 12656 * cos(((fromLocation.latitude + toLocation.latitude) / 2) * M_PI / 180) / 180) +
                (((fromLocation.latitude - toLocation.latitude) * M_PI * 12656/180) * ((fromLocation.latitude - toLocation.latitude) * M_PI * 12656 / 180)));
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
        RCMainLikeInfoModel *informModel = [[RCMainLikeInfoModel alloc] init];
        informModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/ReportUsers.do";
        informModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
        informModel.parameters = @{@"plat": @1,
                                   @"usertoken": usertoken,
                                   @"userid": userInfo.userid
                                   };
        [informModel requestServerWithModel:informModel success:^(id resultModel) {
            RCMainLikeInfoModel *result = (RCMainLikeInfoModel *)resultModel;
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

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self acquirePhotoCount:self.selectedUserInfo];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RCMainLikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
    RCUserInfoModel *userInfo = self.selectedUserInfo;
    
    if (indexPath.item == 0) {
        cell.showImageURL = [NSURL URLWithString:userInfo.url1];
    } else if (indexPath.item == 1) {
        cell.showImageURL = [NSURL URLWithString:userInfo.url2];
    } else if (indexPath.item == 2) {
        cell.showImageURL = [NSURL URLWithString:userInfo.url3];
    }
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    RCUserInfoModel *userInfo = self.selectedUserInfo;
    _indexLabel.text = [NSString stringWithFormat:@"%d/%d", (int)(scrollView.contentOffset.x / (kRCScreenWidth - 40)) + 1, [self acquirePhotoCount:userInfo]];
}

- (void)choiceButtonDidClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if (self.complete) {
        self.complete(sender.tag);
    }
}

@end
