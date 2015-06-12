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

//主页显示Page页书
#define kRCHomePageNumber 3
//主页Cell标识符
#define kRCHomePageCellIdentifer @"RCHomePageCell"
//主页注册按钮宽度
#define kRCRegisterButtonWidth 200.0
//主页注册按钮高度
#define kRCRegisterButtonHeight 60.0
//主页登陆按钮宽度
#define kRCLoginButtonWidth 100.0
//主页登陆按钮高度
#define kRCLoginButtonHeight 40.0
//主页间距
#define kRCMargin 20.0

@interface RCHomeViewController ()
{
    NSArray *_homePageTitleArray;
    NSArray *_homePageImageArray;
}

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *homePageCellLayout;

@end

@implementation RCHomeViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLayout];
    [self initData];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility
//初始化布局
- (void)initLayout {
    _homePageCellLayout.itemSize = kRCScreenBounds.size;
    _homePageCellLayout.minimumLineSpacing = 0;
    _homePageCellLayout.minimumInteritemSpacing = 0;
    _homePageCellLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

//初始化数据
- (void)initData {
    _homePageTitleArray = @[kRCLocalizedString(@"HomeMsgOne"), kRCLocalizedString(@"HomeMsgTwo"), kRCLocalizedString(@"HomeMsgThree")];
#warning 此处设置重绘的背景图片
//    _homePageImageArray = @[kRCImage(@"image1.jpg"), kRCImage(@"image2.jpg"), kRCImage(@"image3.jpg")];
    _homePageImageArray = nil;
}

- (void)setUpUI {
    //添加注册按钮
    [self.view addSubview:[self setUpRegisterButton]];
    //添加登陆按钮
    [self.view addSubview:[self setUpLoginButton]];
}

//创建注册按钮
- (UIButton *)setUpRegisterButton {
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setTitle:kRCLocalizedString(@"HomeRegister") forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    registerButton.frame = CGRectMake((kRCScreenWidth - kRCRegisterButtonWidth) * 0.5, (kRCScreenHeight - kRCRegisterButtonHeight) * 0.75, kRCRegisterButtonWidth, kRCRegisterButtonHeight);
    registerButton.layer.borderWidth = 1.0f;
    registerButton.layer.cornerRadius = 2.0f;
    registerButton.layer.masksToBounds = YES;
    [registerButton addTarget:self action:@selector(registerDidClicked) forControlEvents:UIControlEventTouchUpInside];
    return registerButton;
}

//创建登陆按钮
- (UIButton *)setUpLoginButton {
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:kRCLocalizedString(@"HomeLogin") forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginButton.frame = CGRectMake(kRCScreenWidth * 0.6, (kRCScreenHeight - kRCRegisterButtonHeight) * 0.75 + kRCRegisterButtonHeight + kRCMargin, kRCLoginButtonWidth, kRCLoginButtonHeight);
    loginButton.layer.borderWidth = 1.0f;
    loginButton.layer.cornerRadius = 2.0f;
    loginButton.layer.masksToBounds = YES;
    [loginButton addTarget:self action:@selector(loginDidClicked) forControlEvents:UIControlEventTouchUpInside];
    return loginButton;
}

#pragma mark - Action
//进入注册界面
- (void)registerDidClicked {
    RCRegisterAccountViewController *accountVc = [[RCRegisterAccountViewController alloc] init];
    RCBaseNavgationController *navVc = [[RCBaseNavgationController alloc] initWithRootViewController:accountVc];
    [self presentViewController:navVc animated:YES completion:nil];
}

//进入登陆界面
- (void)loginDidClicked {
    
}

#pragma mark -  <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kRCHomePageNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RCHomePageCell *homePageCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kRCHomePageCellIdentifer forIndexPath:indexPath];
    [homePageCell drawTitle:_homePageTitleArray[indexPath.row] image:_homePageImageArray[indexPath.row]];
    return homePageCell;
}

@end
