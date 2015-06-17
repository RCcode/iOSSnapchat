//
//  RCMainLikeViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/17.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeViewController.h"

@interface RCMainLikeViewController ()

@end

@implementation RCMainLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Snaper";
    
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *likePhotoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 84, kRCScreenWidth - 40, kRCScreenWidth - 40) collectionViewLayout:layout];
    likePhotoCollectionView.backgroundColor = [UIColor redColor];
    [self.view addSubview:likePhotoCollectionView];
}

@end
