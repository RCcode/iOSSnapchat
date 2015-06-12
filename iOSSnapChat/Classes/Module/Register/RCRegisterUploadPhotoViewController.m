//
//  RCRegisterUploadPhotoViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/11.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

typedef NS_ENUM(NSInteger, kRCCamerGalleryTapType) {
    kRCCamerGalleryTapTypeReplace = 0,
    kRCCamerGalleryTapTypeAdd
};

#import "RCRegisterUploadPhotoViewController.h"

@interface RCRegisterUploadPhotoViewController ()
{
    UIImageView *_photoImageView;
    //所有的图片数
    NSInteger _photoCount;
    //点击的图片索引
    NSInteger _tapIndex;
    //当前图片点击类型
    kRCCamerGalleryTapType _currentTapType;
}

@property (nonatomic, strong) NSMutableArray *addPhotoImagageViewArray;

@end

@implementation RCRegisterUploadPhotoViewController

#pragma mark - LazyLoad
- (NSMutableArray *)addPhotoImagageViewArray {
    if (_addPhotoImagageViewArray == nil) {
        _addPhotoImagageViewArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _addPhotoImagageViewArray;
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
    photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    photoImageView.image = _selectedGalleryPhoto;
    _photoCount = 1;
    [self.view addSubview:photoImageView];
    _photoImageView = photoImageView;
    
    //添加照片按钮
    for (int i = 0; i < 3; ++ i) {
        UIImageView *addPhotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + (kRCScreenWidth - 20 - 20 - 10 - 10) / 3 * i + 10 * i, CGRectGetMaxY(photoImageView.frame) + 10, (kRCScreenWidth - 20 - 20 - 10 - 10) / 3, (kRCScreenWidth - 20 - 20 - 10 - 10) / 3)];
        addPhotoImageView.layer.borderWidth = 1;
        addPhotoImageView.layer.cornerRadius = 2;
        addPhotoImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        addPhotoImageView.layer.masksToBounds = YES;
        addPhotoImageView.contentMode = UIViewContentModeScaleAspectFit;
        addPhotoImageView.userInteractionEnabled = YES;
        addPhotoImageView.tag = i;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotoImageDidTap:)];
        [addPhotoImageView addGestureRecognizer:tapRecognizer];
        if (i == 0) [addPhotoImageView setImage:_selectedGalleryPhoto];
        [self.view addSubview:addPhotoImageView];
        [self.addPhotoImagageViewArray addObject:addPhotoImageView];
    }
    
    //介绍文本
    NSString *contentText = @"OK! cool! Upload more photos will increase your chances of find friends!";
    CGSize size = [contentText sizeForLineWithSize:CGSizeMake(kRCScreenWidth - 40, MAXFLOAT) Attributes:@{NSFontAttributeName: kRCSystemFont(17)}];
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(photoImageView.frame) + 10 + (kRCScreenWidth - 20 - 20 - 10 - 10) / 3 + 10, size.width, size.height)];
    msgLabel.numberOfLines = 0;
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.text = contentText;
    [self.view addSubview:msgLabel];
    
    //Go按钮
    UIButton *goButton = [UIButton buttonWithType:UIButtonTypeCustom];
    goButton.frame = CGRectMake(20, CGRectGetMaxY(msgLabel.frame) + 10, kRCScreenWidth - 40, 44);
    [goButton setBackgroundColor:kRCRGBAColor(30, 190, 205, 1)];
    [goButton setTitle:@"Go" forState:UIControlStateNormal];
    [goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:goButton];
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addPhotoImageDidTap:(UITapGestureRecognizer *)recognizer {
    UIImageView *tapImageView = (UIImageView *)recognizer.view;
    _tapIndex = tapImageView.tag;
    if (tapImageView.image) {
        _currentTapType = kRCCamerGalleryTapTypeReplace;
    } else {
        _currentTapType = kRCCamerGalleryTapTypeAdd;
    }
    UIAlertController *uploadAlertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //获取相机图片
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acquireCamaraGalleryPhoto:) name:kRCCameraGalleryNotification object:nil];
        [[RCCamerGalleryManager shareManager] openCameraAcquirePhotoWithCurrentViewController:self];
    }];
    
    //获取相册图片
    UIAlertAction *galleryAction = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acquireCamaraGalleryPhoto:) name:kRCCameraGalleryNotification object:nil];
        [[RCCamerGalleryManager shareManager] openGalleryAcquirePhotoWithCurrentViewController:self];
    }];
    
    [uploadAlertVc addAction:cameraAction];
    [uploadAlertVc addAction:galleryAction];
    [self presentViewController:uploadAlertVc animated:YES completion:nil];
}

- (void)acquireCamaraGalleryPhoto:(NSNotification *)notice {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    UIImage *selectedGalleryPhoto = notice.userInfo[kRCCameraGalleryNotification];
    _photoImageView.image = selectedGalleryPhoto;
    if (_currentTapType == kRCCamerGalleryTapTypeReplace) {
        UIImageView *currentTapImageView = [_addPhotoImagageViewArray objectAtIndex:_tapIndex];
        currentTapImageView.image = selectedGalleryPhoto;
    } else if (_currentTapType == kRCCamerGalleryTapTypeAdd) {
        UIImageView *currentTapImageView = [_addPhotoImagageViewArray objectAtIndex:_photoCount];
        _photoCount += 1;
        currentTapImageView.image = selectedGalleryPhoto;
    }
}

@end
