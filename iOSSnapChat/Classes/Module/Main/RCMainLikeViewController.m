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
#import "RCMainModifyIDModel.h"
#import "RCMainLikeCollectionViewCell.h"
#import "RCMainLikeTableViewCell.h"
#import "RCMainLikePhotoDetailViewController.h"
#import "RCMainLikeMessageViewController.h"
#import "RCMainLikeModifyPhotoViewController.h"
#import "RCLoginViewController.h"
#import "RCBaseNavgationController.h"
#import "RCMainLikeMatchYouViewController.h"
#import <MessageUI/MessageUI.h>

#define kRCMainLikeActionAnimationKey @"kRCMainLikeActionAnimationKey"
#define kRMainLikeCollectionViewCellReuseIdentifier @"kRMainLikeCollectionViewCellReuseIdentifier"
#define kRCMainLikeMenuTableViewCellIdentifer @"kRCMainLikeMenuTableViewCellIdentifer"

#warning modify this
//修改成导航栏约束
#define kRCMainLikeRedTipImageViewOriginX ((kRCDefaultNacgationBarItemFrame.size.width - kRCAdaptationWidth(11)) / 2 + 5)
#define kRCMainLikeRedTipImageViewOriginY ((kRCDefaultNacgationBarItemFrame.size.height - kRCAdaptationHeight(11)) / 2 - 5)
#define kRCMainLikeRedTipImageViewWidth kRCAdaptationWidth(11)
#define kRCMainLikeRedTipImageViewHeight kRCAdaptationHeight(11)

//主界面约束
#define kRCMainLikeBackImageViewTopConstant (kRCAdaptationHeight(22) + 64)
#define kRCMainLikeBackImageViewLeftConstant kRCAdaptationWidth(32)
#define kRCMainLikeBackImageViewRightConstant kRCMainLikeBackImageViewLeftConstant
#define kRCMainLikeBackImageViewHeightConstant ((kRCScreenWidth - kRCAdaptationWidth(32) * 2) + kRCAdaptationHeight(99) + kRCAdaptationHeight(27))

#define kRCMainLikeLikePhotoCollectionViewTopConstant 0
#define kRCMainLikeLikePhotoCollectionViewLeftConstant 0
#define kRCMainLikeLikePhotoCollectionViewWidthConstant (kRCScreenWidth - kRCAdaptationWidth(32) * 2)
#define kRCMainLikeLikePhotoCollectionViewHeightConstant (kRCScreenWidth - kRCAdaptationWidth(32) * 2)

#define kRCMainLikeBackTopShowImageViewTopConstant 0
#define kRCMainLikeBackTopShowImageViewLeftConstant 0
#define kRCMainLikeBackTopShowImageViewRightConstant 0
#define kRCMainLikeBackTopShowImageViewHeightConstant ((kRCScreenWidth - kRCAdaptationWidth(32) * 2) + kRCAdaptationHeight(99))

#define kRCMainLikeIndexLabelBottomConstant (kRCAdaptationHeight(99) + 25)
#define kRCMainLikeIndexLabelRightConstant 10
#define kRCMainLikeIndexLabelWidthConstant 40
#define kRCMainLikeIndexLabelHeightConstant 15

#define kRCMainLikeSexImageViewBottomConstant kRCAdaptationHeight(30)
#define kRCMainLikeSexImageViewLeftConstant kRCAdaptationWidth(50)

#define kRCMainLikeSexImageViewWidthConstant kRCAdaptationWidth(31)
#define kRCMainLikeSexImageViewHeightConstant kRCAdaptationWidth(31)

#define kRCMainLikeAgeLabelBottomConstant kRCAdaptationHeight(30)
#define kRCMainLikeAgeLabelLeftConstant kRCAdaptationWidth(20)
#define kRCMainLikeAgeLabelHeightConstant 15

#define kRCMainLikeDistanceImageViewBottomConstant kRCAdaptationHeight(34)
#define kRCMainLikeDistanceImageViewRightConstant kRCAdaptationWidth(10)
#define kRCMainLikeDistanceImageViewWidthConstant kRCAdaptationWidth(11)
#define kRCMainLikeDistanceImageViewHeightConstant kRCAdaptationHeight(16)

#define kRCMainLikeDistanceLabelBottomConstant kRCAdaptationHeight(34)
#define kRCMainLikeDistanceLabelRightConstant kRCAdaptationWidth(44)
#define kRCMainLikeDistanceLabelHeightConstant 15

#define kRCMainLikeBackBottomImageViewTopConstant 0
#define kRCMainLikeBackBottomImageViewBottomConstant 0
#define kRCMainLikeBackBottomImageViewLeftConstant 0
#define kRCMainLikeBackBottomImageViewRightConstant 0

#define kRCMainLikeUnLikeButtonBottomConstant kRCAdaptationHeight(106)
#define kRCMainLikeUnLikeButtonLeftConstant kRCAdaptationWidth(93)
#define kRCMainLikeUnLikeButtonWidthConstant kRCAdaptationWidth(169)
#define kRCMainLikeUnLikeButtonHeightConstant kRCAdaptationWidth(169)

#define kRCMainLikeLikeButtonBottomConstant kRCAdaptationHeight(106)
#define kRCMainLikeLikeButtonRightConstant kRCAdaptationWidth(93)
#define kRCMainLikeLikeButtonWidthConstant kRCAdaptationWidth(169)
#define kRCMainLikeLikeButtonHeightConstant kRCAdaptationWidth(169)

#define kRCMainLikeShareButtonBottomConstant kRCAdaptationHeight(54)
#define kRCMainLikeShareButtonRightConstant kRCAdaptationWidth(40)
#define kRCMainLikeShareButtonWidthConstant kRCAdaptationWidth(35)
#define kRCMainLikeShareButtonHeightConstant kRCAdaptationHeight(44)

#define kRCMainLikeInformButtonWidthConstant kRCAdaptationWidth(102)
#define kRCMainLikeInformButtonHeightConstant kRCAdaptationWidth(102)

//菜单约束
#define kRCMainLikeMenuViewToRightDistance 40

#define kRCMainLikeMenuViewUserInfoViewTopConstant 0
#define kRCMainLikeMenuViewUserInfoViewLeftConstant 0
#define kRCMainLikeMenuViewUserInfoViewRightConstant 0
#define kRCMainLikeMenuViewUserInfoViewHeightConstant kRCScreenHeight * 0.4

#define kRCMainLikeMenuViewPhotoViewTopConstant kRCAdaptationHeight(104)
#define kRCMainLikeMenuViewPhotoViewLeftConstant kRCAdaptationWidth(190)
#define kRCMainLikeMenuViewPhotoViewWidthConstant (kRCScreenWidth - kRCMainLikeMenuViewToRightDistance - kRCAdaptationWidth(190) * 2)
#define kRCMainLikeMenuViewPhotoViewHeightConstant (kRCScreenWidth - kRCMainLikeMenuViewToRightDistance - kRCAdaptationWidth(190) * 2)

#define kRCMainLikeMenuViewIdLabelBottomConstant 0
#define kRCMainLikeMenuViewIdLabelLeftConstant 0

#define kRCMainLikeMenuViewEditButtonLeftConstant kRCAdaptationWidth(18)
#define kRCMainLikeMenuViewEditButtonWidthConstant kRCAdaptationWidth(23)
#define kRCMainLikeMenuViewEditButtonHeightConstant kRCAdaptationWidth(23)

#define kRCMainLikeMenuViewContentViewBottomConstant kRCAdaptationHeight(28)
#define kRCMainLikeMenuViewContentViewLeftConstant 0
#define kRCMainLikeMenuViewContentViewRightConstant 0

#define kRCMainLikeMenuViewMenuViewTopConstant 0
#define kRCMainLikeMenuViewMenuViewBottomConstant 0
#define kRCMainLikeMenuViewMenuViewLeftConstant 0
#define kRCMainLikeMenuViewMenuViewRightConstant 0

@interface RCMainLikeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
{
    //MainUI
    UIImageView *_redTipImageView;
    UIImageView *_backImageView;
    UICollectionView *_likePhotoCollectionView;
    UIImageView *_backTopShowImageView;
    UILabel *_indexLabel;
    UIImageView *_sexImageView;
    UILabel *_ageLabel;
    UIImageView *_distanceImageView;
    UILabel *_distanceLabel;
    UIImageView *_backBottomImageView;
    UIButton *_unLikeButton;
    UIButton *_likeButton;
    UIButton *_shareButton;
    UIButton *_informButton;
    
    //MenuUI
    UIView *_userInfoView;
    RCPhotoView *_photoView;
    UILabel *_idLabel;
    UIView *_contentView;
    UITableView *_menuView;
    
    //
    UITextView *_idTextView;
    UIButton *_editButton;
    NSMutableArray *_userList;
    NSInteger _currentIndex;
    
    BOOL _isMainLikeMenuViewLazyLoading;
}

@property (nonatomic, strong) UIView *mainLikeCoverView;
@property (nonatomic, strong) UIView *mainLikeMenuView;
@property (nonatomic, strong) UIView *mainLikeEditCoverView;
@property (nonatomic, strong) UIView *mainLikeEditView;
@property (nonatomic, strong) RCMainLikeModifyPhotoViewController *mainLikeModifyPhotoVc;

@end

@implementation RCMainLikeViewController

#pragma mark - LazyLoading
- (UIView *)mainLikeCoverView {
    if (_mainLikeCoverView == nil) {
        UIView *mainLikeCoverView = [[UIView alloc] initWithFrame:kRCScreenBounds];
        mainLikeCoverView.hidden = YES;
        mainLikeCoverView.backgroundColor = [UIColor blackColor];
        mainLikeCoverView.alpha = 0.3;
        [[UIApplication sharedApplication].keyWindow addSubview:mainLikeCoverView];
        _mainLikeCoverView = mainLikeCoverView;
    }
    return _mainLikeCoverView;
}

- (UIView *)mainLikeMenuView {
    if (_mainLikeMenuView == nil) {
        UIView *mainLikeMenuView = [[UIView alloc] init];

        UIView *userInfoView = [[UIView alloc] init];
        userInfoView.backgroundColor = kRCDefaultPurple;
        [mainLikeMenuView addSubview:userInfoView];
        _userInfoView = userInfoView;
        
        RCPhotoView *photoView = [[RCPhotoView alloc] init];
        photoView.photoURL = [NSURL URLWithString:self.loginUserInfo.url1];
        [photoView.camaraButton addTarget:self action:@selector(camaraButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        [userInfoView addSubview:photoView];
        _photoView = photoView;

        UILabel *idLabel = [[UILabel alloc] init];
        idLabel.text = [NSString stringWithFormat:@"ID: %@", self.loginUserInfo.snapchatid];
        idLabel.textColor = [UIColor whiteColor];
        idLabel.textAlignment = NSTextAlignmentCenter;
        [userInfoView addSubview:idLabel];
        _idLabel = idLabel;
        
        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [editButton addTarget:self action:@selector(editButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        [editButton setImage:kRCImage(@"edit_icon") forState:UIControlStateNormal];
        [userInfoView addSubview:editButton];
        _editButton = editButton;
        
        UIView *contentView = [[UIView alloc] init];
        [contentView addSubview:idLabel];
        [contentView addSubview:editButton];
        [userInfoView addSubview:contentView];
        _contentView = contentView;

        UITableView *menuView = [[UITableView alloc] init];
        menuView.bounces = NO;
        menuView.backgroundColor = kRCDefaultBackWhiteColor;
        [menuView registerClass:[RCMainLikeTableViewCell class] forCellReuseIdentifier:kRCMainLikeMenuTableViewCellIdentifer];
        menuView.separatorStyle = UITableViewCellSeparatorStyleNone;
        menuView.dataSource = self;
        menuView.delegate = self;
        [mainLikeMenuView addSubview:menuView];
        _menuView = menuView;
        
        [[UIApplication sharedApplication].keyWindow addSubview:mainLikeMenuView];
        UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerDidSwipe:)];
        swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [mainLikeMenuView addGestureRecognizer:swipeRecognizer];
        
        //约束
        [userInfoView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [mainLikeMenuView addConstraint:[NSLayoutConstraint constraintWithItem:userInfoView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:mainLikeMenuView attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCMainLikeMenuViewUserInfoViewTopConstant]];
        [mainLikeMenuView addConstraint:[NSLayoutConstraint constraintWithItem:userInfoView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:mainLikeMenuView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:kRCMainLikeMenuViewUserInfoViewLeftConstant]];
        [mainLikeMenuView addConstraint:[NSLayoutConstraint constraintWithItem:userInfoView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:mainLikeMenuView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-kRCMainLikeMenuViewUserInfoViewRightConstant]];
        [mainLikeMenuView addConstraint:[NSLayoutConstraint constraintWithItem:userInfoView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMenuViewUserInfoViewHeightConstant]];
        
        [photoView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [userInfoView addConstraint:[NSLayoutConstraint constraintWithItem:photoView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:userInfoView attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCMainLikeMenuViewPhotoViewTopConstant]];
        [userInfoView addConstraint:[NSLayoutConstraint constraintWithItem:photoView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:userInfoView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:kRCMainLikeMenuViewPhotoViewLeftConstant]];
        [userInfoView addConstraint:[NSLayoutConstraint constraintWithItem:photoView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMenuViewPhotoViewWidthConstant]];
        [userInfoView addConstraint:[NSLayoutConstraint constraintWithItem:photoView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMenuViewPhotoViewHeightConstant]];
        
        [idLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:idLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeMenuViewIdLabelBottomConstant]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:idLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:kRCMainLikeMenuViewIdLabelLeftConstant]];
        
        [editButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:editButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:idLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:kRCMainLikeMenuViewEditButtonLeftConstant]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:editButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMenuViewEditButtonWidthConstant]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:editButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMenuViewEditButtonHeightConstant]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:editButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        
        [contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [userInfoView addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:userInfoView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeMenuViewContentViewBottomConstant]];
        [userInfoView addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:idLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:kRCMainLikeMenuViewContentViewLeftConstant]];
        [userInfoView addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:editButton attribute:NSLayoutAttributeRight multiplier:1.0 constant:kRCMainLikeMenuViewContentViewRightConstant]];
        [userInfoView addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:idLabel attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
        [userInfoView addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:userInfoView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];

        [menuView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [mainLikeMenuView addConstraint:[NSLayoutConstraint constraintWithItem:menuView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:userInfoView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCMainLikeMenuViewMenuViewTopConstant]];
        [mainLikeMenuView addConstraint:[NSLayoutConstraint constraintWithItem:menuView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:mainLikeMenuView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeMenuViewMenuViewBottomConstant]];
        [mainLikeMenuView addConstraint:[NSLayoutConstraint constraintWithItem:menuView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:mainLikeMenuView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:kRCMainLikeMenuViewMenuViewLeftConstant]];
        [mainLikeMenuView addConstraint:[NSLayoutConstraint constraintWithItem:menuView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:mainLikeMenuView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-kRCMainLikeMenuViewMenuViewRightConstant]];
        
        _mainLikeMenuView = mainLikeMenuView;
    }
    return _mainLikeMenuView;
}

- (UIView *)mainLikeEditCoverView {
    if (_mainLikeEditCoverView == nil) {
        UIView *mainLikeEditCoverView = [[UIView alloc] initWithFrame:kRCScreenBounds];
        mainLikeEditCoverView.hidden = YES;
        mainLikeEditCoverView.backgroundColor = [UIColor blackColor];
        mainLikeEditCoverView.alpha = 0.3;
        [[UIApplication sharedApplication].keyWindow addSubview:mainLikeEditCoverView];
        _mainLikeEditCoverView = mainLikeEditCoverView;
    }
    return _mainLikeEditCoverView;
}

- (UIView *)mainLikeEditView {
    if (_mainLikeEditView == nil) {
        UIView *mainLikeEditView = [[UIView alloc] initWithFrame:CGRectMake(20, kRCScreenHeight / 3, kRCScreenWidth - 40, kRCScreenHeight / 3)];
        mainLikeEditView.backgroundColor = [UIColor lightGrayColor];
        mainLikeEditView.layer.cornerRadius = 10;
        mainLikeEditView.layer.masksToBounds = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:mainLikeEditView];
        
        //snapchat ID
        UILabel *snapchatIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kRCScreenWidth - 40, 20)];
        snapchatIdLabel.textAlignment = NSTextAlignmentCenter;
        snapchatIdLabel.text = @"Your snapchat ID";
        snapchatIdLabel.textColor = [UIColor darkGrayColor];
        [mainLikeEditView addSubview:snapchatIdLabel];
        
        //ID textfield
        UITextView *idTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, kRCScreenHeight / 3 / 2 - 20, kRCScreenWidth - 40, 40)];
        idTextView.backgroundColor = [UIColor lightGrayColor];
        idTextView.font = kRCBoldSystemFont(17);
        idTextView.textAlignment = NSTextAlignmentCenter;
        [mainLikeEditView addSubview:idTextView];
        _idTextView = idTextView;
        
        UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(idTextView.frame) - 1, kRCScreenWidth - 40 - 40, 1)];
        separatorLine.backgroundColor = [UIColor darkGrayColor];
        [mainLikeEditView addSubview:separatorLine];
        
        //cancel
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(0, kRCScreenHeight / 3 - 40, (kRCScreenWidth - 40) / 2, 40);
        [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        [mainLikeEditView addSubview:cancelButton];
        
        //done
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        doneButton.frame = CGRectMake((kRCScreenWidth - 40) / 2, kRCScreenHeight / 3 - 40, (kRCScreenWidth - 40) / 2, 40);
        [doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(doneButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        [mainLikeEditView addSubview:doneButton];
        
        _mainLikeEditView = mainLikeEditView;
    }
    return _mainLikeEditView;
}

- (RCMainLikeModifyPhotoViewController *)mainLikeModifyPhotoVc {
    if (_mainLikeModifyPhotoVc == nil) {
        RCMainLikeModifyPhotoViewController *mainLikeModifyPhotoVc = [[RCMainLikeModifyPhotoViewController alloc] init];
        mainLikeModifyPhotoVc.userInfo = self.loginUserInfo;
        mainLikeModifyPhotoVc.showImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.loginUserInfo.url1]]];
        mainLikeModifyPhotoVc.complete = ^(UIImage *image) {
            _photoView.photoImageView.image = image;
        };
        _mainLikeModifyPhotoVc = mainLikeModifyPhotoVc;
    }
    return _mainLikeModifyPhotoVc;
}

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navgationSettings];
    [self loadData];
    [self setUpUI];
    [self addConstraint];
    [self addNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_likePhotoCollectionView.layer removeAnimationForKey:kRCMainLikeActionAnimationKey];
    [_mainLikeCoverView removeFromSuperview];
    [_mainLikeMenuView removeFromSuperview];
    [_mainLikeEditCoverView removeFromSuperview];
    [_mainLikeEditView removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Utility
- (void)navgationSettings {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"Snaper";
    self.view.backgroundColor = kRCDefaultBackWhiteColor;

    RCNavgationItemButton *menuButton = [[RCNavgationItemButton alloc] init];
    menuButton.frame = kRCDefaultNacgationBarItemFrame;
    [menuButton setImage:kRCImage(@"more_icon") forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(menuButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    RCNavgationItemButton *messageButton = [[RCNavgationItemButton alloc] init];
    messageButton.frame = kRCDefaultNacgationBarItemFrame;
    [messageButton setImage:kRCImage(@"notice_icon") forState:UIControlStateNormal];
    [messageButton addTarget:self action:@selector(messageButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *redTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRCMainLikeRedTipImageViewOriginX, kRCMainLikeRedTipImageViewOriginY, kRCMainLikeRedTipImageViewWidth, kRCMainLikeRedTipImageViewHeight)];
    redTipImageView.image = kRCImage(@"notice_tishi_icon");
    UIBarButtonItem *messageButtonItem = [[UIBarButtonItem alloc] initWithCustomView:messageButton];
    [messageButton addSubview:redTipImageView];
    _redTipImageView = redTipImageView;
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    self.navigationItem.rightBarButtonItem = messageButtonItem;
}

- (void)loadData {
    RCMainMatchModel *mainMatchModel = [[RCMainMatchModel alloc] init];
    mainMatchModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/excavate/ExcavateUser.do";
    mainMatchModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    
    kAcquireUserDefaultUsertoken
    NSInteger gender2 = [userDefault integerForKey:kRCUserDefaultGenderKey];
    double longitude = [userDefault doubleForKey:kRCUserDefaultLongitudeKey];
    double latitude = [userDefault doubleForKey:kRCUserDefaultLatitudeKey];
    mainMatchModel.parameters = @{@"plat": @1,
                                  @"usertoken": usertoken,
                                  @"gender": self.loginUserInfo.gender,
                                  @"gender2": @(gender2),
                                  @"lon": @(longitude),
                                  @"lat": @(latitude),
                                  @"pageno": @1
                                  };
    
    [mainMatchModel requestServerWithModel:mainMatchModel success:^(id resultModel) {
        RCMainMatchModel *result = (RCMainMatchModel *)resultModel;
        if ([result.mess isEqualToString:@"succ"]) {
            //创建缓存
            NSLog(@"获取数据成功, 刷新最新数据");
            _userList = result.list;
            [_likePhotoCollectionView reloadData];
            [self reloadInfo];
        } else {
            NSLog(@"usertoken错误");
        }
    } failure:^(NSError *error) {
        NSLog(@"服务器错误");
    }];
}

- (void)setUpUI {
    UIImageView *backImageView = [[UIImageView alloc] init];
    [self.view addSubview:backImageView];
    backImageView.userInteractionEnabled = YES;
    _backImageView = backImageView;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *likePhotoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    layout.itemSize = CGSizeMake(kRCMainLikeLikePhotoCollectionViewWidthConstant, kRCMainLikeLikePhotoCollectionViewHeightConstant);
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

    RCHitTestEventThroughImageView *backTopShowImageView = [[RCHitTestEventThroughImageView alloc] init];
    backTopShowImageView.image = kRCImage(@"people_s");
    backTopShowImageView.userInteractionEnabled = YES;
    [backImageView addSubview:backTopShowImageView];
    _backTopShowImageView = backTopShowImageView;

    UILabel *indexLabel = [[UILabel alloc] init];
    indexLabel.layer.cornerRadius = 5;
    indexLabel.layer.masksToBounds = YES;
    indexLabel.font = kRCSystemFont(14);
    indexLabel.textAlignment = NSTextAlignmentCenter;
    indexLabel.backgroundColor = kRCDefaultAlphaBlack;
    indexLabel.textColor = kRCDefaultWhite;
    [backTopShowImageView addSubview:indexLabel];
    _indexLabel = indexLabel;

    UIImageView *sexImageView = [[UIImageView alloc] init];
    [backTopShowImageView addSubview:sexImageView];
    _sexImageView = sexImageView;

    UILabel *ageLabel = [[UILabel alloc] init];
    ageLabel.textColor = kRCDefaultAlphaBlack;
    [backTopShowImageView addSubview:ageLabel];
    _ageLabel = ageLabel;
    
    UIImageView *distanceImageView = [[UIImageView alloc] init];
    distanceImageView.image = kRCImage(@"location_icon");
    [backTopShowImageView addSubview:distanceImageView];
    _distanceImageView = distanceImageView;

    UILabel *distanceLabel = [[UILabel alloc] init];
    [backTopShowImageView addSubview:distanceLabel];
    _distanceLabel = distanceLabel;
    
    UIImageView *backBottomImageView = [[UIImageView alloc] init];
    backBottomImageView.image = kRCImage(@"people_d");
    backBottomImageView.userInteractionEnabled = YES;
    [backImageView addSubview:backBottomImageView];
    _backBottomImageView = backBottomImageView;

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

    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:kRCImage(@"share_icon") forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    _shareButton = shareButton;
    
    UIButton *informButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [informButton setImage:kRCImage(@"jubao_icon") forState:UIControlStateNormal];
    [informButton addTarget:self action:@selector(informButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:informButton];
    _informButton = informButton;
}

- (void)addConstraint {
    [_backImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCMainLikeBackImageViewTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeBackImageViewLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeBackImageViewRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_backImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeBackImageViewHeightConstant]];
    
    [_likePhotoCollectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_likePhotoCollectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_backImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCMainLikeLikePhotoCollectionViewTopConstant]];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_likePhotoCollectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_backImageView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeLikePhotoCollectionViewLeftConstant]];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_likePhotoCollectionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikePhotoCollectionViewWidthConstant]];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_likePhotoCollectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikePhotoCollectionViewHeightConstant]];
    
    [_backTopShowImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_backTopShowImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_backImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCMainLikeBackTopShowImageViewTopConstant]];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_backTopShowImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_backImageView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeBackTopShowImageViewLeftConstant]];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_backTopShowImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_backImageView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeBackTopShowImageViewRightConstant]];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_backTopShowImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeBackTopShowImageViewHeightConstant]];
    
    [_indexLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_backImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeIndexLabelBottomConstant]];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_backImageView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeIndexLabelRightConstant]];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeIndexLabelWidthConstant]];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeIndexLabelHeightConstant]];
    
    [_sexImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_backTopShowImageView addConstraint:[NSLayoutConstraint constraintWithItem:_sexImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_backTopShowImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeSexImageViewBottomConstant]];
    [_backTopShowImageView addConstraint:[NSLayoutConstraint constraintWithItem:_sexImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_backTopShowImageView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeSexImageViewLeftConstant]];
    [_backTopShowImageView addConstraint:[NSLayoutConstraint constraintWithItem:_sexImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeSexImageViewWidthConstant]];
    [_backTopShowImageView addConstraint:[NSLayoutConstraint constraintWithItem:_sexImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeSexImageViewHeightConstant]];
    
    [_ageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_backTopShowImageView addConstraint:[NSLayoutConstraint constraintWithItem:_ageLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_backTopShowImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeAgeLabelBottomConstant]];
    [_backTopShowImageView addConstraint:[NSLayoutConstraint constraintWithItem:_ageLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_sexImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:kRCMainLikeAgeLabelLeftConstant]];
    [_backTopShowImageView addConstraint:[NSLayoutConstraint constraintWithItem:_ageLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeAgeLabelHeightConstant]];
    
    [_distanceImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_backTopShowImageView addConstraint:[NSLayoutConstraint constraintWithItem:_distanceImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_backTopShowImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeDistanceImageViewBottomConstant]];
    [_backTopShowImageView addConstraint:[NSLayoutConstraint constraintWithItem:_distanceImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_distanceLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-kRCMainLikeDistanceImageViewRightConstant]];
    [_backTopShowImageView addConstraint:[NSLayoutConstraint constraintWithItem:_distanceImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeDistanceImageViewWidthConstant]];
    [_backTopShowImageView addConstraint:[NSLayoutConstraint constraintWithItem:_distanceImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeDistanceImageViewHeightConstant]];
    
    [_distanceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_backTopShowImageView addConstraint:[NSLayoutConstraint constraintWithItem:_distanceLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_backTopShowImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeDistanceLabelBottomConstant]];
    [_backTopShowImageView addConstraint:[NSLayoutConstraint constraintWithItem:_distanceLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_backTopShowImageView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeDistanceLabelRightConstant]];
    [_backTopShowImageView addConstraint:[NSLayoutConstraint constraintWithItem:_distanceLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeDistanceLabelHeightConstant]];

    [_backBottomImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_backBottomImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_backTopShowImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCMainLikeBackBottomImageViewTopConstant]];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_backBottomImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_backImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeBackBottomImageViewBottomConstant]];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_backBottomImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_backImageView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeBackBottomImageViewLeftConstant]];
    [_backImageView addConstraint:[NSLayoutConstraint constraintWithItem:_backBottomImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_backImageView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeBackBottomImageViewRightConstant]];

    [_unLikeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_unLikeButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeUnLikeButtonBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_unLikeButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeUnLikeButtonLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_unLikeButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeUnLikeButtonWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_unLikeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeUnLikeButtonHeightConstant]];
    
    [_likeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likeButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeLikeButtonBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likeButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeLikeButtonRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likeButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeButtonWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_likeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeLikeButtonHeightConstant]];
    
    [_shareButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_shareButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeShareButtonBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_shareButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeShareButtonRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_shareButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeShareButtonWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_shareButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeShareButtonHeightConstant]];

    [_informButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_informButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeInformButtonWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_informButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeInformButtonHeightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_informButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_informButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_unLikeButton attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHid:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardDidShow:(NSNotification *)notice {
    
    CGRect keyboardRect = [notice.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.25f animations:^{
        _mainLikeEditView.frame = CGRectMake(20, keyboardRect.origin.y - kRCScreenHeight / 3 - 20, kRCScreenWidth - 40, kRCScreenHeight / 3);
    }];
//    _mainLikeEditView.frame = CGRectMake(20, 20, kRCScreenWidth - 40, kRCScreenHeight / 3);
//    _mainLikeEditView.hidden = NO;
}

- (void)keyboardDidHid:(NSNotification *)notice {
    _mainLikeEditView.frame = CGRectMake(20, kRCScreenHeight / 3, kRCScreenWidth - 40, kRCScreenHeight / 3);
//    _mainLikeEditView.hidden = YES;
}

- (void)reloadInfo {
    if (_userList == nil) return;
    RCUserInfoModel *userInfo = _userList[_currentIndex];
    if (userInfo == nil) return;

    if ([userInfo.gender intValue] == 0) {
        _sexImageView.image = kRCImage(@"boy_xianshi_icon");
    } else if ([userInfo.gender intValue]== 1) {
        _sexImageView.image = kRCImage(@"girl_xianshi_icon");
    }
    _ageLabel.text = [NSString stringWithFormat:@"%d", [userInfo.age intValue]];
    _indexLabel.text = [NSString stringWithFormat:@"%d/%d", 1, [self acquirePhotoCount:userInfo]];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    double userLongitude = [userDefault doubleForKey:kRCUserDefaultLongitudeKey];
    double userLatitude = [userDefault doubleForKey:kRCUserDefaultLatitudeKey];
    double choiceLongtitude = [userInfo.lon floatValue];
    double choiceLatitude = [userInfo.lat floatValue];
    
    if (userLongitude == 0 || userLatitude == 0 || choiceLongtitude == 100000 || choiceLatitude == 100000) {
        _distanceLabel.text = @"";
    } else {
        RCLocation fromLocation = {userLongitude, userLatitude};
        RCLocation toLocation = {choiceLongtitude, choiceLatitude};
        _distanceLabel.text = [NSString stringWithFormat:@"%.1f m", [self distanceFromLocation:fromLocation toLocation:toLocation]];
    }
}


- (float)distanceFromLocation:(RCLocation)fromLocation toLocation:(RCLocation)toLocation {
    return sqrt(((fromLocation.longitude - toLocation.longitude) * M_PI * 12656 * cos(((fromLocation.latitude + toLocation.latitude) / 2) * M_PI / 180) / 180 *
                 (fromLocation.longitude - toLocation.longitude) * M_PI * 12656 * cos(((fromLocation.latitude + toLocation.latitude) / 2) * M_PI / 180) / 180) +
                 (((fromLocation.latitude - toLocation.latitude) * M_PI * 12656/180) * ((fromLocation.latitude - toLocation.latitude) * M_PI * 12656 / 180)));
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
- (void)menuButtonDidClick {
    if (!_isMainLikeMenuViewLazyLoading) {
        //第一次懒加载执行
        self.mainLikeCoverView.hidden = YES;
        self.mainLikeMenuView.frame = CGRectMake(- (kRCScreenWidth - 40), 0, kRCScreenWidth - 40, kRCScreenHeight);
        _isMainLikeMenuViewLazyLoading = YES;
    }
    self.mainLikeCoverView.hidden = NO;
    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.3 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _mainLikeMenuView.frame = CGRectMake(0, 0, kRCScreenWidth - 40, kRCScreenHeight);
    } completion:nil];
}

- (void)gestureRecognizerDidSwipe:(UISwipeGestureRecognizer *)recognizer {
    self.mainLikeCoverView.hidden = YES;
    [UIView animateWithDuration:0.2f animations:^{
        self.mainLikeMenuView.frame = CGRectMake(- (kRCScreenWidth - 40), 0, kRCScreenWidth - 40, kRCScreenHeight);
    }];
}

- (void)messageButtonDidClick {
    RCMainLikeMessageViewController *messageVc = [[RCMainLikeMessageViewController alloc] init];
    messageVc.userInfo = self.loginUserInfo;
    [self.navigationController pushViewController:messageVc animated:YES];
}

- (void)choiceButtonDidClicked:(UIButton *)sender {
    [self sendLikeUnLikeRequest:sender.tag];
}

- (void)sendLikeUnLikeRequest:(kRCMainLikeType)type {
    RCUserInfoModel *userInfo = _userList[_currentIndex];
    NSString *usertoken = [[NSUserDefaults standardUserDefaults] stringForKey:kRCUserDefaultUserTokenKey];
    //发送请求
    RCMainLikeModel *mainLikeModel = [[RCMainLikeModel alloc] init];
    mainLikeModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/message/LikeUser.do";
    mainLikeModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    mainLikeModel.parameters = @{@"plat": @1,
                                 @"usertoken": usertoken,
                                 @"userid2": userInfo.userid,
                                 @"flag": @(type)
                                 };
    
    CATransition *transitionAnimation = [CATransition animation];
    transitionAnimation.duration = 0.5f;
    transitionAnimation.type = kCATransitionPush;
    if (type == kRCMainLikeTypeLike) {
        transitionAnimation.subtype = kCATransitionFromLeft;
    } else if (type == kRCMainLikeTypeUnlike) {
        transitionAnimation.subtype = kCATransitionFromRight;
    }
    [_backImageView.layer addAnimation:transitionAnimation forKey:kRCMainLikeActionAnimationKey];
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
    [self reloadInfo];
    [_likePhotoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    [mainLikeModel requestServerWithModel:mainLikeModel success:^(id resultModel) {
        RCMainLikeModel *result = (RCMainLikeModel *)resultModel;
        if ([result.mess isEqualToString:@"succ"]) {
            NSLog(@"%d", [result.type intValue]);
            if ([result.type intValue] == 2) {
                RCMainLikeMatchYouViewController *mainLikeMatchYouVc = [[RCMainLikeMatchYouViewController alloc] init];
                mainLikeMatchYouVc.iconURLMe = [NSURL URLWithString:self.loginUserInfo.url1];
                mainLikeMatchYouVc.iconURLOhter = [NSURL URLWithString:[result.userinfo url1]];
                mainLikeMatchYouVc.snapchatid = [result.userinfo snapchatid];
                [self.navigationController pushViewController:mainLikeMatchYouVc animated:YES];
            }
            
        } else {
            NSLog(@"Like/UnLike操作失败");
            [RCMBHUDTool showText:@"操作失败，请重新Like/UnLike" hideDelay:1];
        }
    } failure:^(NSError *error) {
        NSLog(@"服务器错误");
    }];
}

- (void)camaraButtonDidClick {
    kRCWeak(self)
    self.mainLikeCoverView.hidden = YES;
    [UIView animateWithDuration:0.5f animations:^{
        weakself.mainLikeMenuView.frame = CGRectMake(- (kRCScreenWidth - 40), 0, kRCScreenWidth - 40, kRCScreenHeight);
    } completion:^(BOOL finished) {
        [weakself.navigationController pushViewController:self.mainLikeModifyPhotoVc animated:YES];
    }];
}

- (void)editButtonDidClick {
    self.mainLikeEditCoverView.hidden = NO;
    self.mainLikeEditView.hidden = NO;
    
    _idTextView.text = [_idLabel.text substringFromIndex:3];
    _idTextView.selectedRange = NSMakeRange(0, _idTextView.text.length);
    [_idTextView becomeFirstResponder];
}

- (void)cancelButtonDidClick {
    self.mainLikeEditCoverView.hidden = YES;
    self.mainLikeEditView.hidden = YES;
    
    [_idTextView resignFirstResponder];
}

- (void)doneButtonDidClick {
    self.mainLikeEditCoverView.hidden = YES;
    self.mainLikeEditView.hidden = YES;
    
    [_idTextView resignFirstResponder];
    //发送请求
    _idLabel.text = [NSString stringWithFormat:@"ID:%@", _idTextView.text];
    CGSize size = [_idLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: _idLabel.font} context:nil].size;
    _editButton.frame = CGRectMake((kRCScreenWidth - 40) / 2 + size.width / 2 + 10 - (200 - (CGRectGetMaxY(_photoView.frame) + 10) - 10 + 10) / 2, CGRectGetMaxY(_photoView.frame) + 10, 200 - (CGRectGetMaxY(_photoView.frame) + 10) - 10, 200 - (CGRectGetMaxY(_photoView.frame) + 10) - 10);
    
    kAcquireUserDefaultUsertoken
    RCMainModifyIDModel *modifyModel = [[RCMainModifyIDModel alloc] init];
    modifyModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/ChangeSnapchat.do";
    modifyModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    modifyModel.parameters = @{@"plat": @1,
                               @"usertoken": usertoken,
                               @"snapchatid": _idTextView.text
                               };
    [modifyModel requestServerWithModel:modifyModel success:^(id resultModel) {
        if ([modifyModel.mess isEqualToString:@"succ"]) {
            [RCMBHUDTool showText:@"修改成功" hideDelay:1];
        } else {
            [RCMBHUDTool showText:@"修改失败" hideDelay:1];
        }
    } failure:^(NSError *error) {
        [RCMBHUDTool showText:@"网络问题" hideDelay:1];
    }];
}

- (void)shareButtonDidClicked {
    NSString *textToShare = @"shareContent";
    UIImage *imageToShare = [UIImage imageNamed:@"default.jpg"];
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
    NSArray *activityItems = @[textToShare, imageToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        NSLog(@"123456");
    };
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:TRUE completion:nil];
}


- (void)informButtonDidClicked {
    
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCMainLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRCMainLikeMenuTableViewCellIdentifer];
    if (indexPath.row == 0) {
        cell.showIcon = kRCImage(@"more_1_icon");
        cell.showTitle = @"Show";
        cell.isMore = YES;
        NSString *moreTitle = nil;
        switch ([[NSUserDefaults standardUserDefaults] integerForKey:kRCUserDefaultGenderKey]) {
            case -1:
                moreTitle = @"NoSetting";
                break;
            case 0:
                moreTitle = @"Boys";
                break;
            case 1:
                moreTitle = @"Girls";
                break;
            case 2:
                moreTitle = @"All";
                break;
            default:
                break;
        }
        cell.moreTitle = moreTitle;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 1) {
        cell.showIcon = kRCImage(@"more_2_icon");
        cell.showTitle = @"Feedback";
        cell.isMore = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.row == 2) {
        cell.showIcon = kRCImage(@"more_3_icon");
        cell.showTitle = @"Share";
        cell.isMore = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.row == 3) {
        cell.showIcon = kRCImage(@"more_4_icon");
        cell.showTitle = @"Log out";
        cell.isMore = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //性取向
        UIAlertController *alertVc = [[UIAlertController alloc] init];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        UIAlertAction *noSettingAction = [UIAlertAction actionWithTitle:@"NoSetting" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [userDefault setInteger:-1 forKey:kRCUserDefaultGenderKey];
            [tableView reloadData];
            [self loadData];
        }];
        UIAlertAction *boysAction = [UIAlertAction actionWithTitle:@"Boys" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [userDefault setInteger:0 forKey:kRCUserDefaultGenderKey];
            [tableView reloadData];
            [self loadData];
        }];
        UIAlertAction *girlsAction = [UIAlertAction actionWithTitle:@"Girls" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [userDefault setInteger:1 forKey:kRCUserDefaultGenderKey];
            [tableView reloadData];
            [self loadData];
        }];
        UIAlertAction *allAction = [UIAlertAction actionWithTitle:@"All" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [userDefault setInteger:2 forKey:kRCUserDefaultGenderKey];
            [tableView reloadData];
            [self loadData];
        }];
        [alertVc addAction:noSettingAction];
        [alertVc addAction:boysAction];
        [alertVc addAction:girlsAction];
        [alertVc addAction:allAction];
        [self presentViewController:alertVc animated:YES completion:nil];
    } else if (indexPath.row == 1) {
        //邮件
        MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
        if (!mailPicker) {
            return;
        }
        mailPicker.mailComposeDelegate = self;
        [mailPicker setSubject:@"Email主题"];
        NSArray *toRecipients = [NSArray arrayWithObjects:@"first@exameple.com", nil];
        [mailPicker setToRecipients:toRecipients];
        NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", nil];
        [mailPicker setCcRecipients:ccRecipients];
        NSArray *bccRecipients = [NSArray arrayWithObjects:@"three@example.com", nil];
        [mailPicker setBccRecipients:bccRecipients];
        [self presentViewController:mailPicker animated:YES completion:nil];
    } else if (indexPath.row == 2) {
        NSString *textToShare = @"shareContent";
        UIImage *imageToShare = [UIImage imageNamed:@"default.jpg"];
        NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
        NSArray *activityItems = @[textToShare, imageToShare, urlToShare];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
        activityVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
            NSLog(@"123456");
        };
        activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
        [self presentViewController:activityVC animated:TRUE completion:nil];
    } else if (indexPath.row == 3) {
        [UIView animateWithDuration:0.2f animations:^{
            [self gestureRecognizerDidSwipe:nil];
        } completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kRCSwitchRootVcNotification object:nil userInfo:@{kRCSwitchRootVcNotificationStepKey: @(-2), kRCSwitchRootVcNotificationVcKey: self.navigationController}];
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRCAdaptationHeight(100);
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RCMainLikePhotoDetailViewController *mainLikePhotoDetailVc = [[RCMainLikePhotoDetailViewController alloc] init];
    mainLikePhotoDetailVc.selectedItem = indexPath.item;
    mainLikePhotoDetailVc.selectedUserInfo = _userList[_currentIndex];
    kRCWeak(self)
    mainLikePhotoDetailVc.complete = ^(kRCMainLikeType type) {
        NSLog(@"执行回调 type = %d", type);
        [weakself sendLikeUnLikeRequest:type];
    };

    [self.navigationController pushViewController:mainLikePhotoDetailVc animated:YES];
}

#pragma mark - <MFMailComposeViewControllerDelegate>
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"用户取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"用户成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"用户点击发送，将邮件放到队列中，还没发送";
            break;
        case MFMailComposeResultFailed:
            msg = @"用户试图保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
    NSLog(@"%@", msg);
}

@end
