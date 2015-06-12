//
//  RCRegisterUploadPhotoViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/11.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegisterUploadPhotoViewController.h"

@interface RCRegisterUploadPhotoViewController ()
{
    UIImage *_selectedOnePhoto;
    UIImage *_selectedTwoPhoto;
    UIImage *_selectedThreePhoto;
}

@property (nonatomic, strong) NSMutableArray *addPhotoButtonArray;

@end

@implementation RCRegisterUploadPhotoViewController

#pragma mark - LazyLoad
- (NSMutableArray *)addPhotoButtonArray {
    if (_addPhotoButtonArray == nil) {
        _addPhotoButtonArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _addPhotoButtonArray;
}

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility
- (void)setUpUI {
    self.arrowTitle = @"Upload photo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //照片
    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 64 + 10, kRCScreenWidth - 120, kRCScreenWidth - 120)];
    photoImageView.layer.cornerRadius = 10;
    photoImageView.layer.masksToBounds = YES;
    photoImageView.image = _selectedGalleryPhoto;
    _selectedOnePhoto = _selectedGalleryPhoto;
    [self.view addSubview:photoImageView];
    
    //添加照片按钮
    for (int i = 0; i < 3; ++ i) {
        UIButton *addPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addPhotoButton.layer.borderWidth = 1;
        addPhotoButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        addPhotoButton.layer.masksToBounds = YES;
        addPhotoButton.frame = CGRectMake(20 + (kRCScreenWidth - 20 - 20 - 10 - 10) / 3 * i + 10 * i, CGRectGetMaxY(photoImageView.frame) + 10, (kRCScreenWidth - 20 - 20 - 10 - 10) / 3, (kRCScreenWidth - 20 - 20 - 10 - 10) / 3);
        if (i == 0) [addPhotoButton setBackgroundImage:_selectedOnePhoto forState:UIControlStateNormal];
        [self.view addSubview:addPhotoButton];
        [self.addPhotoButtonArray addObject:addPhotoButton];
    }
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
