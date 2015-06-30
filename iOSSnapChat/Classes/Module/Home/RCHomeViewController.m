//
//  RCHomeViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/8.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCHomeViewController.h"
#import "RCHomePageCell.h"
#import "RCBaseNavgationController.h"
#import "RCRegisterAccountViewController.h"
#import "RCLoginViewController.h"


#define kRCHomePageNumber 3
#define kRCHomePageCellIdentifer @"kRCHomePageCellIdentifer"

//AutoLayout
#define kRCHomePageControlTopConstant kRCAdaptationHeight(840)

#define kRCHomeRegisterButtonTopConstant 0
#define kRCHomeRegisterButtonLeftConstant kRCAdaptationWidth(34)
#define kRCHomeRegisterButtonRightConstant kRCAdaptationWidth(34)
#define kRCHomeRegisterButtonHeightConstant kRCAdaptationHeight(78)
#define kRCHomeRegisterButtonFont kRCSystemFont(kRCIOSBd(28))

#define kRCHomeLoginButtonTopConstant 0
#define kRCHomeLoginButtonBottomConstant kRCAdaptationHeight(92)
#define kRCHomeLoginButtonFont kRCSystemFont(kRCIOSBd(28))

#define kRCHomePrivacyButtonBottomConstant kRCAdaptationHeight(67)
#define kRCHomePrivacyButtonLeftConstant kRCAdaptationWidth(34)
#define kRCHomePrivacyButtonWidthConstant kRCAdaptationWidth(200)
#define kRCHomePrivacyButtonHeightConstant kRCAdaptationHeight(40)
#define kRCHomePrivacyButtonFont kRCSystemFont(kRCIOSBd(20))

@interface RCHomeViewController ()
{
    //Control
    UIPageControl *_pageControl;
    UIButton *_registerButton;
    UIButton *_loginButton;
    UIButton *_privacyButton;
}

@end

@implementation RCHomeViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLayout];
    [self setUpUI];
    [self addConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Utility
- (void)initLayout {
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[RCHomePageCell class] forCellWithReuseIdentifier:kRCHomePageCellIdentifer];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
}

- (void)setUpUI {
    //CountControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = kRCHomePageNumber;
    [self.view addSubview:pageControl];
    _pageControl = pageControl;
    
    //注册按钮
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.titleLabel.font = kRCHomeRegisterButtonFont;
    [registerButton setTitle:kRCLocalizedString(@"HomeRegisterButtonTitle") forState:UIControlStateNormal];
    [registerButton setBackgroundColor:colorWithHexString(@"2dcfe3")];
    [registerButton addTarget:self action:@selector(registerButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    _registerButton = registerButton;
    
    //登陆按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitleColor:colorWithHexString(@"76f0ff") forState:UIControlStateNormal];
    loginButton.titleLabel.font = kRCHomeLoginButtonFont;
    [loginButton setTitle:kRCLocalizedString(@"HomeLoginButtonTitle") forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    _loginButton = loginButton;

    //Privacy Policy
    RCUnderLineButton *privacyButton = [[RCUnderLineButton alloc] init];
    privacyButton.titleLabel.font = kRCHomePrivacyButtonFont;
    [privacyButton setTitleColor:colorWithHexString(@"ffffff") forState:UIControlStateNormal];
    [privacyButton setTitle:kRCLocalizedString(@"HomePrivacyButtonTitle") forState:UIControlStateNormal];
    [privacyButton addTarget:self action:@selector(privacyButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:privacyButton];
    _privacyButton = privacyButton;
}

- (void)addConstraint {
    [_pageControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCHomePageControlTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];

    [_registerButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_registerButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_pageControl attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCHomeRegisterButtonTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_registerButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCHomeRegisterButtonLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_registerButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCHomeRegisterButtonRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_registerButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCHomeRegisterButtonHeightConstant]];
    
    [_loginButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_loginButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_registerButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCHomeLoginButtonTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_loginButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCHomeLoginButtonBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_loginButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [_privacyButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_privacyButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCHomePrivacyButtonBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_privacyButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCHomePrivacyButtonLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_privacyButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCHomePrivacyButtonWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_privacyButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCHomePrivacyButtonHeightConstant]];
}

#pragma mark - Action
- (void)registerButtonDidClicked {
    RCRegisterAccountViewController *registerAccountVc = [[RCRegisterAccountViewController alloc] init];
    RCBaseNavgationController *navVc = [[RCBaseNavgationController alloc] initWithRootViewController:registerAccountVc];
    [self presentViewController:navVc animated:YES completion:nil];
}

- (void)loginButtonDidClicked {
    RCLoginViewController *loginVc = [[RCLoginViewController alloc] init];
    RCBaseNavgationController *navVc = [[RCBaseNavgationController alloc] initWithRootViewController:loginVc];
    [self presentViewController:navVc animated:YES completion:nil];
}

- (void)privacyButtonDidClicked {
    
}

#pragma mark -  <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kRCHomePageNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RCHomePageCell *homePageCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kRCHomePageCellIdentifer forIndexPath:indexPath];
    homePageCell.bgImage = [UIImage imageNamed:@"bg"];
    
    if (indexPath.item == 0) {
        homePageCell.introduceTitle = kRCLocalizedString(@"HomeIntroducePageOne");
        homePageCell.introduceImage = kRCImage(@"yd1");
    } else if (indexPath.item == 1) {
        homePageCell.introduceTitle = kRCLocalizedString(@"HomeIntroducePageTwo");
        homePageCell.introduceImage = kRCImage(@"yd2");
    } else if (indexPath.item == 2) {
        homePageCell.introduceTitle = kRCLocalizedString(@"HomeIntroducePageThree");
        homePageCell.introduceImage = kRCImage(@"yd3");
    }
    
    return homePageCell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _pageControl.currentPage = scrollView.contentOffset.x / kRCScreenWidth;
}

@end
