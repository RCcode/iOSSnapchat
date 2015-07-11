//
//  RCMainLikePhotoDetailViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/24.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikePhotoDetailViewController.h"
#import "RCMainLikeCollectionViewCell.h"
#import "RCMainLikeInfoModel.h"

#define kRCMainLikePhotoDetailTableViewCellIdentifer @"kRCMainLikePhotoDetailTableViewCellIdentifer"

//主界面约束
#define kRCMainLikeLikePhotoDetailBackgroundTopConstant 64
#define kRCMainLikeLikePhotoDetailBackgroundLeftConstant 0
#define kRCMainLikeLikePhotoDetailBackgroundRigthConstant 0
#define kRCMainLikeLikePhotoDetailBackgroundHeightConstant (kRCScreenWidth - kRCAdaptationWidth(30) * 2)

#define kRCMainLikeLikePhotoDetailCollectionViewTopConstant 0
#define kRCMainLikeLikePhotoDetailCollectionViewLeftConstant kRCAdaptationWidth(30)
#define kRCMainLikeLikePhotoDetailCollectionViewRightConstant kRCAdaptationWidth(30)
#define kRCMainLikeLikePhotoDetailCollectionViewWidthConstant (kRCScreenWidth - kRCAdaptationWidth(30) * 2)
#define kRCMainLikeLikePhotoDetailCollectionViewHeightConstant (kRCScreenWidth - kRCAdaptationWidth(30) * 2)

#define kRCMainLikeLikeIndexLabelBottomConstant 15
#define kRCMainLikeLikeIndexLabelRightConstant (10 + kRCAdaptationWidth(30))
#define kRCMainLikeLikeIndexLabelWidthConstant 40
#define kRCMainLikeLikeIndexLabelHeightConstant 15

#define kRCMainLikeLikeSexImageViewTopConstant kRCAdaptationHeight(50)
#define kRCMainLikeLikeSexImageViewLeftConstant kRCAdaptationWidth(84)
#define kRCMainLikeLikeSexImageViewWidthConstant kRCAdaptationWidth(31)
#define kRCMainLikeLikeSexImageViewHeightConstant kRCAdaptationWidth(31)

#define kRCMainLikeLikeAgeLabelTopConstant kRCAdaptationHeight(50)
#define kRCMainLikeLikeAgeLabelLeftConstant kRCAdaptationWidth(20)
#define kRCMainLikeLikeAgeLabelHeightConstant kRCAdaptationWidth(31)

#define kRCMainLikeLikeDistanceImageViewTopConstant (kRCAdaptationHeight(62) + kRCAdaptationHeight(15))
#define kRCMainLikeLikeDistanceImageViewRightConstant kRCAdaptationWidth(20)
#define kRCMainLikeLikeDistanceImageViewWidthConstant kRCAdaptationWidth(11)
#define kRCMainLikeLikeDistanceImageViewHeightConstant kRCAdaptationHeight(16)

#define kRCMainLikeLikeDistanceLabelTopConstant kRCAdaptationHeight(62)
#define kRCMainLikeLikeDistanceLabelRightConstant kRCAdaptationWidth(76)
#define kRCMainLikeLikeDistanceLabelHeightConstant kRCAdaptationWidth(31)

#define kRCMainLikeLikeUnLikeButtonBottomConstant kRCAdaptationHeight(106)
#define kRCMainLikeLikeUnLikeButtonLeftConstant kRCAdaptationWidth(93)
#define kRCMainLikeLikeUnLikeButtonWidthConstant kRCAdaptationWidth(169)
#define kRCMainLikeLikeUnLikeButtonHeightConstant kRCAdaptationWidth(169)

#define kRCMainLikeLikeLikeButtonBottomConstant kRCAdaptationHeight(106)
#define kRCMainLikeLikeLikeButtonRightConstant kRCAdaptationWidth(93)
#define kRCMainLikeLikeLikeButtonWidthConstant kRCAdaptationWidth(169)
#define kRCMainLikeLikeLikeButtonHeightConstant kRCAdaptationWidth(169)

#define kRCMainLikeLikeInformButtonWidthConstant kRCAdaptationWidth(102)
#define kRCMainLikeLikeInformButtonHeightConstant kRCAdaptationWidth(102)

@interface RCMainLikePhotoDetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    UIView *_backgroundView;
    UICollectionView *_likePhotoCollectionView;
    UILabel *_indexLabel;
    UIImageView *_sexImageView;
    UILabel *_ageLabel;
    UIImageView *_distanceImageView;
    UILabel *_distanceLabel;
    UIButton *_unLikeButton;
    UIButton *_likeButton;
    UIButton *_informButton;
}

@end

@implementation RCMainLikePhotoDetailViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self addConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_likePhotoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedItem inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

#pragma mark - Utility
- (void)setUpUI {
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backgroundView];
    _backgroundView = backgroundView;

    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *likePhotoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    layout.itemSize = CGSizeMake(kRCMainLikeLikePhotoDetailCollectionViewWidthConstant, kRCMainLikeLikePhotoDetailCollectionViewHeightConstant);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    likePhotoCollectionView.pagingEnabled = YES;
    likePhotoCollectionView.showsHorizontalScrollIndicator = NO;
    [likePhotoCollectionView registerClass:[RCMainLikeCollectionViewCell class] forCellWithReuseIdentifier:kRCMainLikePhotoDetailTableViewCellIdentifer];
    likePhotoCollectionView.dataSource = self;
    likePhotoCollectionView.delegate = self;
    [self.view addSubview:likePhotoCollectionView];
    _likePhotoCollectionView = likePhotoCollectionView;
    
    UILabel *indexLabel = [[UILabel alloc] init];
    indexLabel.layer.cornerRadius = 5;
    indexLabel.layer.masksToBounds = YES;
    indexLabel.font = kRCSystemFont(14);
    indexLabel.textAlignment = NSTextAlignmentCenter;
    indexLabel.backgroundColor = kRCDefaultAlphaBlack;
    indexLabel.textColor = kRCDefaultWhite;
    indexLabel.text = [NSString stringWithFormat:@"%d/%d", self.selectedItem + 1, [self acquirePhotoCount:self.selectedUserInfo]];
    [self.view addSubview:indexLabel];
    _indexLabel = indexLabel;

    UIImageView *sexImageView = [[UIImageView alloc] init];
    if ([self.selectedUserInfo.gender intValue] == 0) {
        sexImageView.image = kRCImage(@"boy_xianshi_icon");
    } else if ([self.selectedUserInfo.gender intValue]== 1) {
        sexImageView.image = kRCImage(@"girl_xianshi_icon");
    }
    [self.view addSubview:sexImageView];
    _sexImageView = sexImageView;

    UILabel *ageLabel = [[UILabel alloc] init];
    ageLabel.text = [NSString stringWithFormat:@"%@", self.selectedUserInfo.age];
    [self.view addSubview:ageLabel];
    _ageLabel = ageLabel;
    
    UIImageView *distanceImageView = [[UIImageView alloc] init];
    distanceImageView.image = kRCImage(@"location_icon");
    [self.view addSubview:distanceImageView];
    _distanceImageView = distanceImageView;
    
    UILabel *distanceLabel = [[UILabel alloc] init];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    double userLongitude = [userDefault doubleForKey:kRCUserDefaultLongitudeKey];
    double userLatitude = [userDefault doubleForKey:kRCUserDefaultLatitudeKey];
    double choiceLongtitude = [self.selectedUserInfo.lon floatValue];
    double choiceLatitude = [self.selectedUserInfo.lat floatValue];

    RCLocation fromLocation = {userLongitude, userLatitude};
    RCLocation toLocation = {choiceLongtitude, choiceLatitude};
    distanceLabel.text = [NSString stringWithFormat:@"%d km", [self distanceFromLocation:fromLocation toLocation:toLocation]];
    [self.view addSubview:distanceLabel];
    _distanceLabel = distanceLabel;

    UIButton *unLikeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    unLikeButton.tag = kRCMainLikeTypeUnlike;
    [unLikeButton setImage:kRCImage(@"pass_icon") forState:UIControlStateNormal];
    [unLikeButton setImage:kRCImage(@"pass_pass_icon") forState:UIControlStateHighlighted];
    [unLikeButton addTarget:self action:@selector(choiceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:unLikeButton];
    _unLikeButton = unLikeButton;

    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.tag = kRCMainLikeTypeLike;
    [likeButton setImage:kRCImage(@"like_icon") forState:UIControlStateNormal];
    [likeButton setImage:kRCImage(@"like_press_icon") forState:UIControlStateHighlighted];
    [likeButton addTarget:self action:@selector(choiceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeButton];
    _likeButton = likeButton;
    
    UIButton *informButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [informButton setImage:kRCImage(@"jubao_icon") forState:UIControlStateNormal];
    [informButton addTarget:self action:@selector(informButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:informButton];
    _informButton = informButton;
}

- (void)addConstraint {
    [_backgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCMainLikeLikePhotoDetailBackgroundTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeLikePhotoDetailBackgroundLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeLikePhotoDetailBackgroundRigthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikePhotoDetailBackgroundHeightConstant]];
    
    [_likePhotoCollectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likePhotoCollectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_backgroundView attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCMainLikeLikePhotoDetailCollectionViewTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likePhotoCollectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_backgroundView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:kRCMainLikeLikePhotoDetailCollectionViewLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likePhotoCollectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_backgroundView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-kRCMainLikeLikePhotoDetailCollectionViewRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likePhotoCollectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikePhotoDetailCollectionViewHeightConstant]];
    
    [_indexLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_backgroundView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeLikeIndexLabelBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_backgroundView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-kRCMainLikeLikeIndexLabelRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeIndexLabelWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeIndexLabelHeightConstant]];

    [_sexImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_sexImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_backgroundView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCMainLikeLikeSexImageViewTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_sexImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeLikeSexImageViewLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_sexImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeSexImageViewWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_sexImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeSexImageViewHeightConstant]];
    
    [_ageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_ageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_backgroundView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCMainLikeLikeAgeLabelTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_ageLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_sexImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:kRCMainLikeLikeAgeLabelLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_ageLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeAgeLabelHeightConstant]];

    [_distanceImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_distanceImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_backgroundView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCMainLikeLikeDistanceImageViewTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_distanceImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_distanceLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-kRCMainLikeLikeDistanceImageViewRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_distanceImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeDistanceImageViewWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_distanceImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeDistanceImageViewHeightConstant]];

    [_distanceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_distanceLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_backgroundView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCMainLikeLikeDistanceLabelTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_distanceLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeLikeDistanceLabelRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_distanceLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeDistanceLabelHeightConstant]];
    
    [_unLikeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_unLikeButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeLikeUnLikeButtonBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_unLikeButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeLikeUnLikeButtonLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_unLikeButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeUnLikeButtonWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_unLikeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeUnLikeButtonHeightConstant]];
    
    [_likeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likeButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeLikeUnLikeButtonBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likeButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeLikeUnLikeButtonLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likeButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeUnLikeButtonWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeUnLikeButtonHeightConstant]];
    
    [_informButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_informButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeInformButtonWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_informButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeInformButtonHeightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_informButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_informButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_unLikeButton attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
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

- (int)distanceFromLocation:(RCLocation)fromLocation toLocation:(RCLocation)toLocation {
    int resultM = sqrt(((fromLocation.longitude - toLocation.longitude) * M_PI * 12656 * cos(((fromLocation.latitude + toLocation.latitude) / 2) * M_PI / 180) / 180 *
                        (fromLocation.longitude - toLocation.longitude) * M_PI * 12656 * cos(((fromLocation.latitude + toLocation.latitude) / 2) * M_PI / 180) / 180) +
                       (((fromLocation.latitude - toLocation.latitude) * M_PI * 12656/180) * ((fromLocation.latitude - toLocation.latitude) * M_PI * 12656 / 180)));
    return resultM;
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)informButtonDidClicked {
    UIAlertController *informAlertVc = [[UIAlertController alloc] init];
    kAcquireUserDefaultUsertoken
    RCUserInfoModel *userInfo = self.selectedUserInfo;
    UIAlertAction *informAction = [UIAlertAction actionWithTitle:@"Inform" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        RCMainLikeInfoModel *informModel = [[RCMainLikeInfoModel alloc] init];
        informModel.requestUrl = [Global shareGlobal].mainLikeInformURLString;
        informModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
        informModel.parameters = @{@"plat": @1,
                                   @"usertoken": usertoken,
                                   @"userid": userInfo.userid
                                   };
        [informModel requestServerWithModel:informModel success:^(id resultModel) {
            RCMainLikeInfoModel *result = (RCMainLikeInfoModel *)resultModel;
            if ([result.state intValue] == 10000) {
                [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeInformErrorCodeSucc") hideDelay:1];
            } else if ([result.state intValue] == 10004) {
                [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeInformErrorCodeUsertokenError") hideDelay:1];
            } else {
                [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeInformErrorCodeCannotConnectServer") hideDelay:1];
            }
        } failure:^(NSError *error) {
            [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeInformErrorCodeNetworkError") hideDelay:1];
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
    RCMainLikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRCMainLikePhotoDetailTableViewCellIdentifer forIndexPath:indexPath];
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
    _indexLabel.text = [NSString stringWithFormat:@"%d/%d", (int)(scrollView.contentOffset.x / (kRCScreenWidth - kRCMainLikeLikePhotoDetailCollectionViewLeftConstant * 2)) + 1, [self acquirePhotoCount:userInfo]];
}

- (void)choiceButtonDidClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if (self.complete) {
        self.complete(sender.tag);
    }
}

@end
