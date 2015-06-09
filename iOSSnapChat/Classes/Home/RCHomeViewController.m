//
//  RCHomeViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/8.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCHomeViewController.h"
#import "RCHomePageCell.h"

#define kRCHomePageNumber 3
#define kRCHomePageCellIdentifer @"RCHomePageCell"

@interface RCHomeViewController ()
{
    NSArray *_homePageTitleArray;
}

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *homePageCellLayout;

@end

@implementation RCHomeViewController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLayout];
    [self initData];
}

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
    _homePageTitleArray = @[NSLocalizedString(@"HomePageOneTitle", nil), NSLocalizedString(@"HomePageTwoTitle", nil), NSLocalizedString(@"HomePageThreeTitle", nil)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -  <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kRCHomePageNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RCHomePageCell *homePageCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kRCHomePageCellIdentifer forIndexPath:indexPath];
    homePageCell.drawTitle = _homePageTitleArray[indexPath.row];
    return homePageCell;
}

@end
