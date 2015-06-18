//
//  RCMainLikeViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/17.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeViewController.h"
#import "RCMainMatchModel.h"
#import "RCMainLikeModel.h"
#import "RCMainLikeCollectionViewCell.h"

typedef NS_ENUM(NSInteger, kRCMainLikeType) {
    kRCMainLikeTypeUnlike = 0,
    kRCMainLikeTypeLike
};

#define kRMainLikeCollectionViewCellReuseIdentifier @"kRMainLikeCollectionViewCellReuseIdentifier"

@interface RCMainLikeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray *_userList;
    NSInteger _currentIndex;
    
    UIImageView *_backImageView;
    UICollectionView *_likePhotoCollectionView;
    UIImageView *_sexImageView;
    UILabel *_ageLabel;
    UILabel *_indexLabel;
}
@end

@implementation RCMainLikeViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Snaper";
    
    [self loadData];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility
- (void)loadData {
    RCMainMatchModel *mainMatchModel = [[RCMainMatchModel alloc] init];
    mainMatchModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/excavate/ExcavateUser.do";
    mainMatchModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *usertoken = [userDefault stringForKey:kRCUserDefaultUserTokenKey];
    double longitude = [userDefault doubleForKey:kRCUserDefaultLongitudeKey];
    double latitude = [userDefault doubleForKey:kRCUserDefaultLatitudeKey];
    mainMatchModel.parameters = @{@"plat": @1,
                                  @"usertoken": usertoken,
                                  @"gender": self.loginUserInfo.gender,
                                  @"gender2": self.loginUserInfo.gender2,
                                  @"lon": @(longitude),
                                  @"lat": @(latitude),
                                  @"pageno": @1
                                  };
    
    [mainMatchModel requestServerWithModel:mainMatchModel success:^(id resultModel) {
        RCMainMatchModel *result = (RCMainMatchModel *)resultModel;
        if ([result.mess isEqualToString:@"succ"]) {
            NSLog(@"获取数据成功, 刷新最新数据");
            _userList = result.list;
            [_likePhotoCollectionView reloadData];
            [self reloadSexAndAge];
        } else {
            NSLog(@"usertoken错误");
        }
    } failure:^(NSError *error) {
        NSLog(@"服务器错误");
    }];
}

- (void)setUpUI {
#warning frame
    //背景图片
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 84, kRCScreenWidth - 40, kRCScreenWidth - 40 + 60)];
    backImageView.backgroundColor = [UIColor yellowColor];
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];
    _backImageView = backImageView;
    
    //好友展示
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *likePhotoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kRCScreenWidth - 40, kRCScreenWidth - 40) collectionViewLayout:layout];
    layout.itemSize = CGSizeMake(likePhotoCollectionView.frame.size.width, likePhotoCollectionView.frame.size.height);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    likePhotoCollectionView.pagingEnabled = YES;
    likePhotoCollectionView.showsHorizontalScrollIndicator = NO;
    [likePhotoCollectionView registerClass:[RCMainLikeCollectionViewCell class] forCellWithReuseIdentifier:kRMainLikeCollectionViewCellReuseIdentifier];
    likePhotoCollectionView.dataSource = self;
    likePhotoCollectionView.delegate = self;
    [backImageView addSubview:likePhotoCollectionView];
    _likePhotoCollectionView = likePhotoCollectionView;
    
    //indexLabel
    UILabel *indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRCScreenWidth - 40 - 40, kRCScreenWidth - 40 - 20, 40, 20)];
    [backImageView addSubview:indexLabel];
    _indexLabel = indexLabel;
    
    //Sex
    UIImageView *sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(likePhotoCollectionView.frame) + 20, 20, 20)];
    [backImageView addSubview:sexImageView];
    _sexImageView = sexImageView;
    
    //Age
    UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(sexImageView.frame) + 10, CGRectGetMaxY(likePhotoCollectionView.frame) + 20, 20, 20)];
    [backImageView addSubview:ageLabel];
    _ageLabel = ageLabel;
    
    //UnLike
    UIButton *unLikeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    unLikeButton.tag = kRCMainLikeTypeUnlike;
    unLikeButton.frame = CGRectMake((kRCScreenWidth - 120 - 20) / 2, CGRectGetMaxY(backImageView.frame) + 20, 60, 60);
    [unLikeButton setTitle:@"UnLike" forState:UIControlStateNormal];
    [unLikeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [unLikeButton addTarget:self action:@selector(choiceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:unLikeButton];
    
    //Like
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.tag = kRCMainLikeTypeLike;
    likeButton.frame = CGRectMake(CGRectGetMaxX(unLikeButton.frame) + 20, CGRectGetMaxY(backImageView.frame) + 20, 60, 60);
    [likeButton setTitle:@"Like" forState:UIControlStateNormal];
    [likeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [likeButton addTarget:self action:@selector(choiceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeButton];
}

- (void)reloadSexAndAge {
    if (_userList == nil) return;
    RCUserInfoModel *userInfo = _userList[_currentIndex];
    if (userInfo == nil) return;

    if ([userInfo.gender intValue] == 0) {
        _sexImageView.backgroundColor = [UIColor blueColor];
    } else if ([userInfo.gender intValue]== 1) {
        _sexImageView.backgroundColor = [UIColor redColor];
    }
    _ageLabel.text = [NSString stringWithFormat:@"%d", [userInfo.age intValue]];
    _indexLabel.text = [NSString stringWithFormat:@"%d/%d", 1, [self acquirePhotoCount:userInfo]];
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

#pragma mark - Action
- (void)choiceButtonDidClicked:(UIButton *)sender {
    
    RCUserInfoModel *userInfo = _userList[_currentIndex];
    NSString *usertoken = [[NSUserDefaults standardUserDefaults] stringForKey:kRCUserDefaultUserTokenKey];
    //发送请求
    RCMainLikeModel *mainLikeModel = [[RCMainLikeModel alloc] init];
    mainLikeModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/message/LikeUser.do";
    mainLikeModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    mainLikeModel.parameters = @{@"plat": @1,
                                 @"usertoken": usertoken,
                                 @"userid2": userInfo.userid,
                                 @"type": @(sender.tag)
                                 };
    
    [mainLikeModel requestServerWithModel:mainLikeModel success:^(id resultModel) {
        RCMainLikeModel *result = (RCMainLikeModel *)resultModel;
        if ([result.mess isEqualToString:@"succ"]) {
            if (sender.tag == kRCMainLikeTypeLike) {
                //执行喜欢动画
                [UIView beginAnimations:@"like" context:nil];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationDuration:1];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:_backImageView cache:YES];
                [UIView commitAnimations];
            } else if (sender.tag == kRCMainLikeTypeUnlike) {
                //执行不喜欢动画
                NSLog(@"执行不喜欢动画");
            }
            
            _currentIndex ++;
            //浏览完当前数据
            if (_currentIndex == 20) {
                NSLog(@"重新刷数据");
                [self loadData];
                _currentIndex = 0;
                return;
            }
            //刷新数据
            [_likePhotoCollectionView reloadData];
            [self reloadSexAndAge];
            [_likePhotoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        } else {
            NSLog(@"Like/UnLike操作失败");
            [RCMBHUDTool showText:@"操作失败，请重新Like/UnLike" hideDelay:1];
        }
    } failure:^(NSError *error) {
        NSLog(@"服务器错误");
    }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self acquirePhotoCount:_userList[_currentIndex]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RCMainLikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRMainLikeCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    RCUserInfoModel *userInfo = _userList[_currentIndex];

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
    RCUserInfoModel *userInfo = _userList[_currentIndex];
    _indexLabel.text = [NSString stringWithFormat:@"%d/%d", (int)(scrollView.contentOffset.x / (kRCScreenWidth - 40)) + 1, [self acquirePhotoCount:userInfo]];
}

@end
