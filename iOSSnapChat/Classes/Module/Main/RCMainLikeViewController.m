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
#import "RCMainLikeInfoModel.h"
#import "RCMainLikeCollectionViewCell.h"
#import "RCMainLikeTableViewCell.h"
#import "RCMainLikePhotoDetailViewController.h"
#import "RCMainLikeMessageViewController.h"
#import "RCMainLikeModifyPhotoViewController.h"
#import "RCMainLikePolicyViewController.h"
#import "RCLoginViewController.h"
#import "RCBaseNavgationController.h"
#import "RCMainLikeMatchYouViewController.h"
#import <MessageUI/MessageUI.h>
#import "SDWebImagePrefetcher.h"

#define kRMainLikeCollectionViewCellReuseIdentifier @"kRMainLikeCollectionViewCellReuseIdentifier"
#define kRCMainLikeMenuTableViewCellIdentifer @"kRCMainLikeMenuTableViewCellIdentifer"

#warning modify this
//修改成导航栏约束
#define kRCMainLikeRedTipImageViewOriginX ((kRCDefaultNacgationBarItemFrame.size.width - kRCAdaptationWidth(15)) / 2 + 5)
#define kRCMainLikeRedTipImageViewOriginY ((kRCDefaultNacgationBarItemFrame.size.height - kRCAdaptationHeight(16)) / 2 - 5)
#define kRCMainLikeRedTipImageViewWidth kRCAdaptationWidth(15)
#define kRCMainLikeRedTipImageViewHeight kRCAdaptationHeight(16)

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
#define kRCMainLikeAgeLabelHeightConstant kRCAdaptationWidth(31)

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
#define kRCMainLikeMenuViewToRightDistance kRCAdaptationWidth(100)

#define kRCMainLikeMenuViewUserInfoViewTopConstant 0
#define kRCMainLikeMenuViewUserInfoViewLeftConstant 0
#define kRCMainLikeMenuViewUserInfoViewRightConstant 0
#define kRCMainLikeMenuViewUserInfoViewHeightConstant kRCScreenHeight * 0.35

#define kRCMainLikeMenuViewPhotoViewTopConstant kRCAdaptationHeight(104)
#define kRCMainLikeMenuViewPhotoViewLeftConstant kRCAdaptationWidth(190)
#define kRCMainLikeMenuViewPhotoViewWidthConstant (kRCScreenWidth - kRCMainLikeMenuViewToRightDistance - kRCAdaptationWidth(190) * 2)
#define kRCMainLikeMenuViewPhotoViewHeightConstant (kRCScreenWidth - kRCMainLikeMenuViewToRightDistance - kRCAdaptationWidth(190) * 2)

#define kRCMainLikeMenuViewIdLabelBottomConstant 0
#define kRCMainLikeMenuViewIdLabelLeftConstant 0

#define kRCMainLikeMenuViewEditButtonLeftConstant kRCAdaptationWidth(18)
#define kRCMainLikeMenuViewEditButtonWidthConstant kRCAdaptationWidth(23)
#define kRCMainLikeMenuViewEditButtonHeightConstant kRCAdaptationWidth(23)

#define kRCMainLikeMenuViewContentViewTopConstant kRCAdaptationHeight(10)
#define kRCMainLikeMenuViewContentViewBottomConstant kRCAdaptationHeight(28)
#define kRCMainLikeMenuViewContentViewLeftConstant 0
#define kRCMainLikeMenuViewContentViewRightConstant 0

#define kRCMainLikeMenuViewMenuViewTopConstant 0
#define kRCMainLikeMenuViewMenuViewBottomConstant 0
#define kRCMainLikeMenuViewMenuViewLeftConstant 0
#define kRCMainLikeMenuViewMenuViewRightConstant 0

//修改id约束
#define kRCMainLikeMainLikeEditViewBottomConstant (253 + 20)
#define kRCMainLikeMainLikeEditViewWidthConstant kRCAdaptationWidth(530)
#define kRCMainLikeMainLikeEditViewHeightConstant kRCAdaptationHeight(352)

#define kRCMainLikeSnapchatIdLabelHeightConstant kRCAdaptationHeight(40)

#define kRCMainLikeMainLikeIdTextViewWidthConstant kRCAdaptationWidth(530)
#define kRCMainLikeMainLikeIdTextViewHeightConstant kRCAdaptationHeight(70)

#define kRCMainLikeSeparatorHorizontalLineTopConstant 0
#define kRCMainLikeSeparatorHorizontalLineLeftConstant kRCAdaptationWidth(30)
#define kRCMainLikeSeparatorHorizontalLineRightConstant kRCAdaptationWidth(30)
#define kRCMainLikeSeparatorHorizontalLineHeightConstant 1

#define kRCMainLikeCancelButtonBottomConstant 0
#define kRCMainLikeCancelButtonLeftConstant 0
#define kRCMainLikeCancelButtonWidthConstant (kRCAdaptationWidth(530) / 2)
#define kRCMainLikeCancelButtonHeightConstant kRCAdaptationHeight(70)

#define kRCMainLikeDoneButtonBottomConstant 0
#define kRCMainLikeDoneButtonRightConstant 0
#define kRCMainLikeDoneButtonWidthConstant (kRCAdaptationWidth(530) / 2)
#define kRCMainLikeDoneButtonHeightConstant kRCAdaptationHeight(70)

#define kRCMainLikeSeparatorVerticalLineTopConstant 5
#define kRCMainLikeSeparatorVerticalLineBottomConstant 5
#define kRCMainLikeSeparatorVerticalLineWidthConstant 1

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
    UILabel *_idLabel;
    UIView *_contentView;
    UITableView *_menuView;
    
    UITextView *_idTextView;
    UIButton *_editButton;
    NSInteger _currentIndex;
    BOOL _isMainLikeMenuViewLazyLoading;
    UIImageView *_animationImageView;
    BOOL _isAnimation;
}

@property (nonatomic, strong) RCPhotoView *photoView;
@property (nonatomic, strong) UIView *mainLikeCoverView;
@property (nonatomic, strong) UIView *mainLikeMenuView;
@property (nonatomic, strong) UIView *mainLikeEditCoverView;
@property (nonatomic, strong) UIView *mainLikeEditView;
@property (nonatomic, strong) RCMainLikeModifyPhotoViewController *mainLikeModifyPhotoVc;
@property (nonatomic, strong) NSMutableArray *userList;
@property (nonatomic, strong) NSMutableString *lastUseridString;

@end

@implementation RCMainLikeViewController

#pragma mark - LazyLoading
- (NSMutableArray *)userList {
    if (_userList == nil) {
        _userList = [NSMutableArray array];
    }
    return _userList;
}

- (NSMutableString *)lastUseridString {
    if (_lastUseridString == nil) {
        _lastUseridString = [NSMutableString string];
    }
    return _lastUseridString;
}

- (UIView *)mainLikeCoverView {
    if (_mainLikeCoverView == nil) {
        UIView *mainLikeCoverView = [[UIView alloc] initWithFrame:kRCScreenBounds];
        mainLikeCoverView.hidden = YES;
        mainLikeCoverView.backgroundColor = kRCRGBAColor(0, 0, 0, 1);
        mainLikeCoverView.alpha = 0.3;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerDidSwipe:)];
        [mainLikeCoverView addGestureRecognizer:tapRecognizer];
        
        [[UIApplication sharedApplication].keyWindow addSubview:mainLikeCoverView];
        _mainLikeCoverView = mainLikeCoverView;
    }
    return _mainLikeCoverView;
}

- (UIView *)mainLikeMenuView {
    if (_mainLikeMenuView == nil) {
        UIView *mainLikeMenuView = [[UIView alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:mainLikeMenuView];
        UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerDidSwipe:)];
        swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [mainLikeMenuView addGestureRecognizer:swipeRecognizer];

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
        idLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editButtonDidClick)];
        [idLabel addGestureRecognizer:tapRecognizer];
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
        [userInfoView addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:photoView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCMainLikeMenuViewContentViewTopConstant]];
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
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerDidTap:)];
        [mainLikeEditCoverView addGestureRecognizer:tapRecognizer];
        [[UIApplication sharedApplication].keyWindow addSubview:mainLikeEditCoverView];
        _mainLikeEditCoverView = mainLikeEditCoverView;
    }
    return _mainLikeEditCoverView;
}

- (UIView *)mainLikeEditView {
    if (_mainLikeEditView == nil) {
        UIView *mainLikeEditView = [[UIView alloc] init];
        mainLikeEditView.backgroundColor = colorWithHexString(@"fafafa");
        mainLikeEditView.layer.cornerRadius = 10;
        mainLikeEditView.layer.masksToBounds = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:mainLikeEditView];

        UILabel *snapchatIdLabel = [[UILabel alloc] init];
        snapchatIdLabel.textAlignment = NSTextAlignmentCenter;
        snapchatIdLabel.text = kRCLocalizedString(@"MainLikeEditViewSnapchatIDLabelTitle");
        snapchatIdLabel.backgroundColor = colorWithHexString(@"fafafa");
        snapchatIdLabel.textColor = kRCDefaultLightgray;
        [mainLikeEditView addSubview:snapchatIdLabel];
        
        UITextView *idTextView = [[UITextView alloc] init];
        idTextView.font = kRCBoldSystemFont(17);
        idTextView.textAlignment = NSTextAlignmentCenter;
        [mainLikeEditView addSubview:idTextView];
        _idTextView = idTextView;

        UIView *separatorHorizontalLine = [[UIView alloc] init];
        separatorHorizontalLine.backgroundColor = kRCDefaultLightgray;
        [mainLikeEditView addSubview:separatorHorizontalLine];

        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.backgroundColor = kRCDefaultWhite;
        [cancelButton setTitle:kRCLocalizedString(@"MainLikeEditViewCancelButtonTitle") forState:UIControlStateNormal];
        [cancelButton setTitleColor:kRCDefaultLightgray forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        [mainLikeEditView addSubview:cancelButton];
        
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        doneButton.backgroundColor = kRCDefaultWhite;
        [doneButton setTitle:kRCLocalizedString(@"MainLikeEditViewDoneButtonTitle") forState:UIControlStateNormal];
        [doneButton setTitleColor:kRCDefaultLightgray forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(doneButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        [mainLikeEditView addSubview:doneButton];

        UIView *separatorVerticalLine = [[UIView alloc] init];
        separatorVerticalLine.backgroundColor = kRCDefaultLightgray;
        [mainLikeEditView addSubview:separatorVerticalLine];
    
        //约束
        [mainLikeEditView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [[UIApplication sharedApplication].keyWindow addConstraint:[NSLayoutConstraint constraintWithItem:mainLikeEditView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeMainLikeEditViewBottomConstant]];
        [[UIApplication sharedApplication].keyWindow addConstraint:[NSLayoutConstraint constraintWithItem:mainLikeEditView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMainLikeEditViewWidthConstant]];
        [[UIApplication sharedApplication].keyWindow addConstraint:[NSLayoutConstraint constraintWithItem:mainLikeEditView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMainLikeEditViewHeightConstant]];
        [[UIApplication sharedApplication].keyWindow addConstraint:[NSLayoutConstraint constraintWithItem:mainLikeEditView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:[UIApplication sharedApplication].keyWindow attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];

        [snapchatIdLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:snapchatIdLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:mainLikeEditView attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCMainLikeSnapchatIdLabelHeightConstant]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:snapchatIdLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:mainLikeEditView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        
        [idTextView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:idTextView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:mainLikeEditView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:idTextView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:mainLikeEditView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:idTextView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMainLikeIdTextViewWidthConstant]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:idTextView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeMainLikeIdTextViewHeightConstant]];
        
        [separatorHorizontalLine setTranslatesAutoresizingMaskIntoConstraints:NO];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:separatorHorizontalLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:idTextView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCMainLikeSeparatorHorizontalLineTopConstant]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:separatorHorizontalLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:mainLikeEditView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:kRCMainLikeSeparatorHorizontalLineLeftConstant]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:separatorHorizontalLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:mainLikeEditView attribute:NSLayoutAttributeRight multiplier:1.0 constant:kRCMainLikeSeparatorHorizontalLineRightConstant]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:separatorHorizontalLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeSeparatorHorizontalLineHeightConstant]];
        
        [cancelButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:cancelButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:mainLikeEditView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeCancelButtonLeftConstant]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:cancelButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:mainLikeEditView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:kRCMainLikeCancelButtonLeftConstant]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:cancelButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeCancelButtonWidthConstant]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:cancelButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeCancelButtonHeightConstant]];
        
        [doneButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:doneButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:mainLikeEditView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeDoneButtonBottomConstant]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:doneButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:mainLikeEditView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-kRCMainLikeDoneButtonRightConstant]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:doneButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeDoneButtonWidthConstant]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:doneButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeDoneButtonHeightConstant]];

        [separatorVerticalLine setTranslatesAutoresizingMaskIntoConstraints:NO];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:separatorVerticalLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cancelButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCMainLikeSeparatorVerticalLineTopConstant]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:separatorVerticalLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cancelButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeSeparatorVerticalLineBottomConstant]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:separatorVerticalLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeSeparatorVerticalLineWidthConstant]];
        [mainLikeEditView addConstraint:[NSLayoutConstraint constraintWithItem:separatorVerticalLine attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:mainLikeEditView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        
        _mainLikeEditView = mainLikeEditView;
    }
    return _mainLikeEditView;
}

- (RCMainLikeModifyPhotoViewController *)mainLikeModifyPhotoVc {
    if (_mainLikeModifyPhotoVc == nil) {
        RCMainLikeModifyPhotoViewController *mainLikeModifyPhotoVc = [[RCMainLikeModifyPhotoViewController alloc] init];
        mainLikeModifyPhotoVc.userInfo = self.loginUserInfo;
        kRCWeak(self);
        mainLikeModifyPhotoVc.complete = ^(UIImage *image) {
            weakself.photoView.photoImageView.image = image;
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
    [_mainLikeCoverView removeFromSuperview];
    [_mainLikeMenuView removeFromSuperview];
    [_mainLikeEditCoverView removeFromSuperview];
    [_mainLikeEditView removeFromSuperview];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Utility
- (void)navgationSettings {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = kRCLocalizedString(@"MainLikeInformNavigationTitle");
    self.view.backgroundColor = kRCDefaultBackWhiteColor;

    RCNavgationItemButton *menuButton = [[RCNavgationItemButton alloc] init];
    menuButton.frame = kRCDefaultNacgationBarItemFrame;
    [menuButton setImage:kRCImage(@"more") forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(menuButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    RCNavgationItemButton *messageButton = [[RCNavgationItemButton alloc] init];
    messageButton.frame = kRCDefaultNacgationBarItemFrame;
    [messageButton setImage:kRCImage(@"notice") forState:UIControlStateNormal];
    [messageButton addTarget:self action:@selector(messageButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *redTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kRCMainLikeRedTipImageViewOriginX, kRCMainLikeRedTipImageViewOriginY, kRCMainLikeRedTipImageViewWidth, kRCMainLikeRedTipImageViewHeight)];
    redTipImageView.image = kRCImage(@"notice_tishi");
    UIBarButtonItem *messageButtonItem = [[UIBarButtonItem alloc] initWithCustomView:messageButton];
    [messageButton addSubview:redTipImageView];
    _redTipImageView = redTipImageView;
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    self.navigationItem.rightBarButtonItem = messageButtonItem;
}

- (void)loadData {
    RCMainMatchModel *mainMatchModel = [[RCMainMatchModel alloc] init];
    mainMatchModel.requestUrl = [Global shareGlobal].mainLikeLoadingListURLString;
    mainMatchModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    
    kAcquireUserDefaultUsertoken
    NSInteger gender2 = [userDefault integerForKey:kRCUserDefaultGenderKey];
    double longitude = [userDefault doubleForKey:kRCUserDefaultLongitudeKey];
    double latitude = [userDefault doubleForKey:kRCUserDefaultLatitudeKey];

    mainMatchModel.parameters = @{@"plat": @1,
                                  @"usertoken": usertoken,
                                  @"userids": self.lastUseridString,
                                  @"gender": self.loginUserInfo.gender,
                                  @"gender2": @(gender2),
                                  @"lon": @(longitude),
                                  @"lat": @(latitude),
                                  @"pageno": @1
                                  };
//    NSLog(@"@", self.useridString);
    [mainMatchModel requestServerWithModel:mainMatchModel success:^(id resultModel) {
        RCMainMatchModel *result = (RCMainMatchModel *)resultModel;
        if ([result.state intValue] == 10000) {
            [RCMBHUDTool hideshowIndicator];
//            _userList = result.list;
            if ([result.list count] < 20) {
                [RCMBHUDTool showText:@"没有更多内容" hideDelay:1.0f];
                return;
            }
            self.lastUseridString = nil;
            for (RCUserInfoModel *info in result.list) {
                [self.lastUseridString appendString:[NSString stringWithFormat:@",%@",info.userid]];
            }

            [self.userList addObjectsFromArray:result.list];
            
            NSMutableArray *preList = [NSMutableArray array];
            for (RCUserInfoModel*info in result.list) {
                if (![info.url1 isEqualToString:@""]) {
                    [preList addObject:[NSURL URLWithString:info.url1]];
                }
                if (![info.url2 isEqualToString:@""]) {
                    [preList addObject:[NSURL URLWithString:info.url2]];
                }
                if (![info.url3 isEqualToString:@""]) {
                    [preList addObject:[NSURL URLWithString:info.url3]];
                }
            }
            [[SDWebImagePrefetcher sharedImagePrefetcher] prefetchURLs:preList];
            [_likePhotoCollectionView reloadData];
            [self reloadInfo];
        } else if ([result.state intValue] == 10004) {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeLikeLoadingListErrorCodeUsertokenError") hideDelay:1.0f];
        }
        else {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeLikeLoadingListErrorCodeCannotConnectServer") hideDelay:1.0f];
        }
    } failure:^(NSError *error) {
        [RCMBHUDTool hideshowIndicator];
        [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeLikeLoadingListErrorCodeNetworkError") hideDelay:1.0f];
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
    likePhotoCollectionView.bounces = NO;
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
    [informButton setImage:kRCImage(@"jubao_press_icon") forState:UIControlStateHighlighted];
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
    self.mainLikeEditView.hidden = NO;
}

- (void)keyboardDidHid:(NSNotification *)notice {
    self.mainLikeEditView.hidden = YES;
}

- (void)reloadInfo {
    if (_currentIndex >= 20) return;
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

    RCLocation fromLocation = {userLongitude, userLatitude};
    RCLocation toLocation = {choiceLongtitude, choiceLatitude};
    _distanceLabel.text = [NSString stringWithFormat:@"%d km", [self distanceFromLocation:fromLocation toLocation:toLocation]];
}

- (int)distanceFromLocation:(RCLocation)fromLocation toLocation:(RCLocation)toLocation {
    int resultM = sqrt(((fromLocation.longitude - toLocation.longitude) * M_PI * 12656 * cos(((fromLocation.latitude + toLocation.latitude) / 2) * M_PI / 180) / 180 *
                 (fromLocation.longitude - toLocation.longitude) * M_PI * 12656 * cos(((fromLocation.latitude + toLocation.latitude) / 2) * M_PI / 180) / 180) +
                 (((fromLocation.latitude - toLocation.latitude) * M_PI * 12656/180) * ((fromLocation.latitude - toLocation.latitude) * M_PI * 12656 / 180)));
    return resultM;
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

- (UIImage *)currentShowImage {
    int selectedIndex = (int)(_likePhotoCollectionView.contentOffset.x / (kRCScreenWidth - kRCMainLikeBackImageViewLeftConstant * 2));
    RCMainLikeCollectionViewCell *showCell = (RCMainLikeCollectionViewCell *)[_likePhotoCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:selectedIndex inSection:0]];
    return showCell.showImageView.image;
}

#pragma mark - Action
- (void)menuButtonDidClick {
    if (!_isMainLikeMenuViewLazyLoading) {
        self.mainLikeCoverView.hidden = YES;
        self.mainLikeMenuView.frame = CGRectMake(- (kRCScreenWidth - kRCMainLikeMenuViewToRightDistance), 0, kRCScreenWidth - kRCMainLikeMenuViewToRightDistance, kRCScreenHeight);
        _isMainLikeMenuViewLazyLoading = YES;
    }
    self.mainLikeCoverView.hidden = NO;
    [UIView animateWithDuration:0.25f animations:^{
        _mainLikeMenuView.frame = CGRectMake(0, 0, kRCScreenWidth - kRCMainLikeMenuViewToRightDistance, kRCScreenHeight);
    }];
}

- (void)gestureRecognizerDidTap:(UITapGestureRecognizer *)recognizer {
    self.mainLikeEditCoverView.hidden = YES;
    self.mainLikeEditView.hidden = YES;
    [_idTextView resignFirstResponder];
}

- (void)gestureRecognizerDidSwipe:(UISwipeGestureRecognizer *)recognizer {
    self.mainLikeCoverView.hidden = YES;
    [UIView animateWithDuration:0.25f animations:^{
        self.mainLikeMenuView.frame = CGRectMake(- (kRCScreenWidth - kRCMainLikeMenuViewToRightDistance), 0, kRCScreenWidth - kRCMainLikeMenuViewToRightDistance, kRCScreenHeight);
    }];
}

- (void)messageButtonDidClick {
    RCMainLikeMessageViewController *messageVc = [[RCMainLikeMessageViewController alloc] init];
    messageVc.userInfo = self.loginUserInfo;
    [self.navigationController pushViewController:messageVc animated:YES];
}

- (void)choiceButtonDidClicked:(UIButton *)sender {
    if (_isAnimation) return;
    _isAnimation = YES;
    [self sendLikeUnLikeRequest:sender.tag];
}

- (void)sendLikeUnLikeRequest:(kRCMainLikeType)type {
    //执行动画
    UIImageView *animationImageView = [[UIImageView alloc] initWithImage:[self currentShowImage]];
    animationImageView.frame = _likePhotoCollectionView.frame;
    [_backImageView addSubview:animationImageView];
    _animationImageView = animationImageView;
    UIImageView *likeImageView = [[UIImageView alloc] init];
    [animationImageView addSubview:likeImageView];
    likeImageView.alpha = 0;
    if (type == kRCMainLikeTypeLike) {
        likeImageView.image = kRCImage(@"like_ani_icon");
        likeImageView.frame = CGRectMake(kRCAdaptationWidth(22), kRCAdaptationHeight(35), kRCAdaptationWidth(172), kRCAdaptationHeight(172));
        [UIView animateWithDuration:0.25f animations:^{
            likeImageView.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25f animations:^{
                _animationImageView.transform = CGAffineTransformMakeTranslation(kRCScreenWidth * 2, 0);
                _animationImageView.transform = CGAffineTransformRotate(_animationImageView.transform, M_PI_4);
            } completion:^(BOOL finished) {
                _isAnimation = NO;
                [_animationImageView removeFromSuperview];
            }];
        }];
    } else if (type == kRCMainLikeTypeUnlike) {
        likeImageView.image = kRCImage(@"pass_ani_icon");
        likeImageView.frame = CGRectMake(_likePhotoCollectionView.frame.size.width - kRCAdaptationWidth(22) - kRCAdaptationWidth(172), kRCAdaptationHeight(35), kRCAdaptationWidth(172), kRCAdaptationHeight(172));
        [UIView animateWithDuration:0.25f animations:^{
            likeImageView.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25f animations:^{
                _animationImageView.transform = CGAffineTransformMakeTranslation(- kRCScreenWidth * 2, 0);
                _animationImageView.transform = CGAffineTransformRotate(_animationImageView.transform, - M_PI_4);
            } completion:^(BOOL finished) {
                _isAnimation = NO;
                [_animationImageView removeFromSuperview];
            }];
        }];
    }
    
    //获取请求需要信息 刷新UI
    RCUserInfoModel *userInfo = _userList[_currentIndex];
    NSString *usertoken = [[NSUserDefaults standardUserDefaults] stringForKey:kRCUserDefaultUserTokenKey];

    _currentIndex ++;
    [_likePhotoCollectionView reloadData];
    [self reloadInfo];
    
    if (_userList.count == 20 && _currentIndex == 10) {
        //第11次时候 移除前10个
        [_userList removeObjectsInRange:NSMakeRange(0, 10)];
        [self loadData];
        _currentIndex = 0;
    }
    
    if (_userList.count == 30 & _currentIndex == 20) {
        [_userList removeObjectsInRange:NSMakeRange(0, 20)];
        [self loadData];
        _currentIndex = 0;
    }
    
    [_likePhotoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    //发送请求
    RCMainLikeModel *mainLikeModel = [[RCMainLikeModel alloc] init];
    mainLikeModel.requestUrl = [Global shareGlobal].mainLikeLikeUnLikeURLString;
    mainLikeModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    mainLikeModel.parameters = @{@"plat": @1,
                                 @"usertoken": usertoken,
                                 @"userid2": userInfo.userid,
                                 @"flag": @(type)
                                 };
    [mainLikeModel requestServerWithModel:mainLikeModel success:^(id resultModel) {
        RCMainLikeModel *result = (RCMainLikeModel *)resultModel;
        if ([result.state intValue] == 10000) {
            if ([result.type intValue] == 2) {
                RCMainLikeMatchYouViewController *mainLikeMatchYouVc = [[RCMainLikeMatchYouViewController alloc] init];
                mainLikeMatchYouVc.iconURLMe = [NSURL URLWithString:self.loginUserInfo.url1];
                mainLikeMatchYouVc.iconURLOhter = [NSURL URLWithString:[result.userinfo url1]];
                mainLikeMatchYouVc.snapchatid = [result.userinfo snapchatid];
                [self.navigationController pushViewController:mainLikeMatchYouVc animated:YES];
            }
        } else if ([result.state intValue] == 10004) {
            [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeLikeUnLikeErrorCodeUsertokenError") hideDelay:1];
        } else {
            [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeLikeUnLikeErrorCodeCannotConnectServer") hideDelay:1];
        }
    } failure:^(NSError *error) {
        [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeLikeUnLikeErrorCodeNetworkError") hideDelay:1];
    }];
}

- (void)camaraButtonDidClick {
    kRCWeak(self)
    self.mainLikeCoverView.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        weakself.mainLikeMenuView.frame = CGRectMake(- (kRCScreenWidth - kRCMainLikeMenuViewToRightDistance), 0, kRCScreenWidth - kRCMainLikeMenuViewToRightDistance, kRCScreenHeight);
    } completion:^(BOOL finished) {
        [weakself.navigationController pushViewController:self.mainLikeModifyPhotoVc animated:YES];
    }];
}

- (void)editButtonDidClick {
    self.mainLikeEditCoverView.hidden = NO;
    self.mainLikeEditView.hidden = NO;
    
    _idTextView.text = [_idLabel.text substringFromIndex:4];
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
    _idLabel.text = [NSString stringWithFormat:@"ID: %@", _idTextView.text];
    kAcquireUserDefaultUsertoken
    RCMainModifyIDModel *modifyModel = [[RCMainModifyIDModel alloc] init];
    modifyModel.requestUrl = [Global shareGlobal].mainLikeModifySnapchatURLString;
    modifyModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    modifyModel.parameters = @{@"plat": @1,
                               @"usertoken": usertoken,
                               @"snapchatid": _idTextView.text
                               };
    [modifyModel requestServerWithModel:modifyModel success:^(id resultModel) {
        if ([modifyModel.state intValue] == 10000) {
            [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeModifySnapchatIdErrorCodeSucc") hideDelay:1];
        } else if ([modifyModel.state intValue] == 10004) {
            [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeModifySnapchatIdErrorCodeUsertokenError") hideDelay:1];
        } else {
            [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeModifySnapchatIdErrorCodeCannotConnectServer") hideDelay:1];
        }
    } failure:^(NSError *error) {
        [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeModifySnapchatIdErrorCodeNetworkError") hideDelay:1];
    }];
}

- (void)shareButtonDidClicked {
    UIImage *holeImage = [self currentShowImage];
    UIImage *backImage = kRCImage(@"share-other");
    UIImage *resultImage = [self addImage:holeImage toImage:backImage];
    NSArray *activityItems = @[resultImage];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
        if (completed) {
            [RCMBHUDTool showText:@"分享成功" hideDelay:1.0f];
        }
    };
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    UIGraphicsBeginImageContext(CGSizeMake(kRCAdaptationWidth(1000), kRCAdaptationWidth(1000)));
    [image1 drawInRect:CGRectMake(kRCAdaptationWidth(59), kRCAdaptationWidth(208), kRCAdaptationWidth(244), kRCAdaptationWidth(244))];
    [image2 drawInRect:CGRectMake(0, 0, kRCAdaptationWidth(1000), kRCAdaptationWidth(1000))];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

- (void)informButtonDidClicked {
    UIAlertController *informAlertVc = [[UIAlertController alloc] init];
    kAcquireUserDefaultUsertoken
    RCUserInfoModel *userInfo = _userList[_currentIndex];
    UIAlertAction *informAction = [UIAlertAction actionWithTitle:kRCLocalizedString(@"MainLikeInformActionTitleInform") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
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
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:kRCLocalizedString(@"MainLikeInformActionTitleCancel") style:UIAlertActionStyleCancel handler:nil];
    [informAlertVc addAction:informAction];
    [informAlertVc addAction:cancelAction];
    [self presentViewController:informAlertVc animated:YES completion:nil];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCMainLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRCMainLikeMenuTableViewCellIdentifer];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.showIcon = kRCImage(@"more_1_icon");
        cell.showTitle = kRCLocalizedString(@"MainLikeMenuTableViewTitleShow");
        cell.isMore = YES;
        NSString *moreTitle = nil;
        switch ([[NSUserDefaults standardUserDefaults] integerForKey:kRCUserDefaultGenderKey]) {
            case -1:
                moreTitle = kRCLocalizedString(@"MainLikeMenuTableViewTitleShowCategoryNosetting");
                break;
            case 0:
                moreTitle = kRCLocalizedString(@"MainLikeMenuTableViewTitleShowCategoryBoys");
                break;
            case 1:
                moreTitle = kRCLocalizedString(@"MainLikeMenuTableViewTitleShowCategoryGirls");
                break;
            case 2:
                moreTitle = kRCLocalizedString(@"MainLikeMenuTableViewTitleShowCategoryAll");
                break;
            default:
                break;
        }
        cell.moreTitle = moreTitle;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 1) {
        cell.showIcon = kRCImage(@"more_2_icon");
        cell.showTitle = kRCLocalizedString(@"MainLikeMenuTableViewTitleFeedback");
        cell.isMore = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.row == 2) {
        cell.showIcon = kRCImage(@"more_3_icon");
        cell.showTitle = kRCLocalizedString(@"MainLikeMenuTableViewTitleShare");
        cell.isMore = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.row == 3) {
        cell.showIcon = kRCImage(@"iconmark");
        cell.showTitle = @"Rate this app";
        cell.isMore = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.row == 4) {
        
        cell.showIcon = kRCImage(@"iconintroduce");
        cell.showTitle = @"Privacy Policy";
        cell.isMore = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.row == 5) {
        cell.showIcon = kRCImage(@"more_4_icon");
        cell.showTitle = kRCLocalizedString(@"MainLikeMenuTableViewTitleLogout");
        cell.isMore = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UIAlertController *alertVc = [[UIAlertController alloc] init];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        kRCWeak(self);
        UIAlertAction *noSettingAction = [UIAlertAction actionWithTitle:kRCLocalizedString(@"MainLikeMenuTableViewTitleShowCategoryNosetting") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [RCMBHUDTool showIndicator];
            [userDefault setInteger:-1 forKey:kRCUserDefaultGenderKey];
            weakself.userList = nil;
            _currentIndex = 0;
            [tableView reloadData];
            [weakself loadData];
            [weakself gestureRecognizerDidSwipe:nil];
        }];
        UIAlertAction *boysAction = [UIAlertAction actionWithTitle:kRCLocalizedString(@"MainLikeMenuTableViewTitleShowCategoryBoys") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [RCMBHUDTool showIndicator];
            [userDefault setInteger:0 forKey:kRCUserDefaultGenderKey];
            weakself.userList = nil;
            _currentIndex = 0;
            [tableView reloadData];
            [weakself loadData];
            [weakself gestureRecognizerDidSwipe:nil];
        }];
        UIAlertAction *girlsAction = [UIAlertAction actionWithTitle:kRCLocalizedString(@"MainLikeMenuTableViewTitleShowCategoryGirls") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [RCMBHUDTool showIndicator];
            [userDefault setInteger:1 forKey:kRCUserDefaultGenderKey];
            weakself.userList = nil;
            _currentIndex = 0;
            [tableView reloadData];
            [weakself loadData];
            [weakself gestureRecognizerDidSwipe:nil];
        }];
        UIAlertAction *allAction = [UIAlertAction actionWithTitle:kRCLocalizedString(@"MainLikeMenuTableViewTitleShowCategoryAll") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [RCMBHUDTool showIndicator];
            [userDefault setInteger:2 forKey:kRCUserDefaultGenderKey];
            weakself.userList = nil;
            _currentIndex = 0;
            [tableView reloadData];
            [weakself loadData];
            [weakself gestureRecognizerDidSwipe:nil];
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
        [mailPicker setSubject:@"Snaper feedback(iOS)"];
        NSArray *toRecipients = [NSArray arrayWithObjects:@"rcplatform.help@gmail.com", nil];
        [mailPicker setToRecipients:toRecipients];
        //        NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", nil];
        //        [mailPicker setCcRecipients:ccRecipients];
        //        NSArray *bccRecipients = [NSArray arrayWithObjects:@"three@example.com", nil];
        //        [mailPicker setBccRecipients:bccRecipients];
        
        NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];
        NSString* phoneModel = [[UIDevice currentDevice] model];
        NSString *contentString = [NSString stringWithFormat:@"%@ %@ %@", strSysVersion, phoneModel, [[NSUserDefaults standardUserDefaults] objectForKey:kRCUserDefaultCountryIDKey]];
        [mailPicker setMessageBody:contentString isHTML:YES];
        [self presentViewController:mailPicker animated:YES completion:nil];    } else if (indexPath.row == 2) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.loginUserInfo.url1] options:SDWebImageRetryFailed progress:NULL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            UIImage *holeImage = image;
            UIImage *backImage = kRCImage(@"share-myself");
            UIImage *resultImage = [self addImage:holeImage toImage:backImage];
            NSArray *activityItems = @[resultImage];
            UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
            activityVC.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
                if (completed) {
                    [RCMBHUDTool showText:@"分享成功" hideDelay:1.0f];
                }
            };
            [self presentViewController:activityVC animated:YES completion:nil];
        }];
        } else if (indexPath.row == 3) {
            NSString *markString = nil;
            NSString *idString = @"123456";
            if(IOS7){
                markString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", idString];
            }else {
                markString = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", idString];
            }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:markString]];
        } else if (indexPath.row == 4) {
            RCMainLikePolicyViewController *policyVc = [[RCMainLikePolicyViewController alloc] init];
            kRCWeak(self);
            [UIView animateWithDuration:0.25 animations:^{
                [weakself gestureRecognizerDidSwipe:nil];
            } completion:^(BOOL finished) {
                [weakself.navigationController pushViewController:policyVc animated:YES];
            }];
        } else if (indexPath.row == 5) {
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"真的要注销么？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            kRCWeak(self);
            UIAlertAction *actionSure = [UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [UIView animateWithDuration:0.25 animations:^{
                    [weakself gestureRecognizerDidSwipe:nil];
                } completion:^(BOOL finished) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kRCSwitchRootVcNotification object:nil userInfo:@{kRCSwitchRootVcNotificationStepKey: @(-2), kRCSwitchRootVcNotificationVcKey: weakself.navigationController}];
                }];
            }];
            UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            [alertVc addAction:actionSure];
            [alertVc addAction:actionCancel];
            [self presentViewController:alertVc animated:YES completion:nil];
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRCAdaptationHeight(100);
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_currentIndex >= 20) {
        return 0;
    }
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
    _indexLabel.text = [NSString stringWithFormat:@"%d/%d", (int)(scrollView.contentOffset.x / (kRCScreenWidth - kRCMainLikeBackImageViewLeftConstant * 2)) + 1, [self acquirePhotoCount:userInfo]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RCMainLikePhotoDetailViewController *mainLikePhotoDetailVc = [[RCMainLikePhotoDetailViewController alloc] init];
    mainLikePhotoDetailVc.selectedItem = indexPath.item;
    mainLikePhotoDetailVc.selectedUserInfo = _userList[_currentIndex];
    kRCWeak(self)
    mainLikePhotoDetailVc.complete = ^(kRCMainLikeType type) {
        [weakself sendLikeUnLikeRequest:type];
    };
    [self.navigationController pushViewController:mainLikePhotoDetailVc animated:YES];
}

#pragma mark - <MFMailComposeViewControllerDelegate>
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
//    NSString *msg;
//    switch (result) {
//        case MFMailComposeResultCancelled:
//            msg = @"用户取消编辑邮件";
//            break;
//        case MFMailComposeResultSaved:
//            msg = @"用户成功保存邮件";
//            break;
//        case MFMailComposeResultSent:
//            msg = @"用户点击发送，将邮件放到队列中，还没发送";
//            break;
//        case MFMailComposeResultFailed:
//            msg = @"用户试图保存或者发送邮件失败";
//            break;
//        default:
//            msg = @"";
//            break;
//    }
}

@end
