//
//  RCMainLikeModifyPhotoViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/25.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeModifyPhotoViewController.h"
#import "RCUserInfoModel.h"

typedef NS_ENUM(NSInteger, kRCCamerGalleryTapType) {
    kRCCamerGalleryTapTypeReplace = 0,
    kRCCamerGalleryTapTypeAdd
};

@interface RCMainLikeModifyPhotoViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSInteger _photoCount;
    //当前图片点击类型
    kRCCamerGalleryTapType _currentTapType;
    NSInteger _tapIndex;
    NSInteger _uploadIndex;
    UICollectionView *_photoCollectionView;
}

@property (nonatomic, strong) NSMutableArray *choiceImageViewArray;

@end

@implementation RCMainLikeModifyPhotoViewController


#pragma mark - LazyLoading
- (NSMutableArray *)choiceImageViewArray {
    if (_choiceImageViewArray == nil) {
        _choiceImageViewArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _choiceImageViewArray;
}

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _photoCount = [self acquirePhotoCount:self.userInfo];
    
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility
- (void)setUpUI {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UICollectionViewFlowLayout *photoCollectLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(40, 64 + 10, kRCScreenWidth - 80, kRCScreenWidth - 80) collectionViewLayout:photoCollectLayout];
    photoCollectionView.layer.cornerRadius = 5;
    photoCollectionView.layer.masksToBounds = YES;
    photoCollectLayout.itemSize = CGSizeMake(kRCScreenWidth - 80, kRCScreenWidth - 80);
    photoCollectLayout.minimumLineSpacing = 0;
    photoCollectLayout.minimumInteritemSpacing = 0;
    photoCollectLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    photoCollectionView.showsHorizontalScrollIndicator = NO;
    photoCollectionView.pagingEnabled = YES;
    photoCollectionView.backgroundColor = [UIColor whiteColor];
    [photoCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"AAAA"];
    photoCollectionView.dataSource = self;
    photoCollectionView.delegate = self;
    [self.view addSubview:photoCollectionView];
    _photoCollectionView = photoCollectionView;
    
    for (int i = 0; i < 3; ++ i) {
        UIImageView *choiceImageView = [[UIImageView alloc] init];
        choiceImageView.frame = CGRectMake(40 + 10 * i + (kRCScreenWidth - 80 - 20) / 3 * i, CGRectGetMaxY(photoCollectionView.frame) + 20, (kRCScreenWidth - 80 - 20) / 3, (kRCScreenWidth - 80 - 20) / 3);
        choiceImageView.tag = i;
        switch (i) {
            case 0: {
                [choiceImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.url1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [_photoCollectionView reloadData];
                }];
            }
                break;
            case 1: {
                [choiceImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.url2] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [_photoCollectionView reloadData];
                }];
            }
                break;
            case 2: {
                [choiceImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.url3] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [_photoCollectionView reloadData];
                }];
            }
                break;
            default:
                break;
        }
        
        choiceImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizerDidTap:)];
        [choiceImageView addGestureRecognizer:tapRecognizer];
        [self.view addSubview:choiceImageView];
        [self.choiceImageViewArray addObject:choiceImageView];
    }
    
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
- (void)arrowBackDidClicked {
    if (self.complete) {
        self.complete(_showImage);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapRecognizerDidTap:(UITapGestureRecognizer *)recognizer {
    UIImageView *tapImageView = (UIImageView *)recognizer.view;
    _tapIndex = recognizer.view.tag;
    if (tapImageView.image) {
        _currentTapType = kRCCamerGalleryTapTypeReplace;
    } else {
        _currentTapType = kRCCamerGalleryTapTypeAdd;
    }

    UIAlertController *uploadAlertVc = [[UIAlertController alloc] init];
    
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
    [self.navigationController popViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    UIImage *selectedPhoto = notice.userInfo[kRCCameraGalleryNotification];
    
    //获取更新显示照片
    if (_tapIndex == 0) {
        _showImage = selectedPhoto;
    }
    
    if (_currentTapType == kRCCamerGalleryTapTypeReplace) {
        //替换
        _uploadIndex = _tapIndex + 1;
    } else if (_currentTapType == kRCCamerGalleryTapTypeAdd) {
        //添加
        _uploadIndex = _photoCount + 1;
    }

    //上传图片
    kAcquireUserDefaultUsertoken
    NSData *uploadImageDataOne = UIImageJPEGRepresentation(selectedPhoto, 1.0f);
    [RCMBHUDTool showIndicator];
    [[RCNetworkManager shareManager] POSTRequest:@"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/Regi3.do?method=upload" parameters:@{@"plat": @1, @"usertoken": usertoken, @"index": @(_uploadIndex)} upateFileData:uploadImageDataOne success:^(id responseObject) {
        [RCMBHUDTool hideshowIndicator];
        UIImageView *updateImageView = self.choiceImageViewArray[_uploadIndex - 1];
        updateImageView.image = selectedPhoto;
        [_photoCollectionView reloadData];
        
        if (_currentTapType == kRCCamerGalleryTapTypeAdd) _photoCount += 1;
        [RCMBHUDTool showText:[NSString stringWithFormat:@"更新完成第%d张", _uploadIndex] hideDelay:1];
    } failure:^(NSError *error) {
        [RCMBHUDTool showText:@"上传失败" hideDelay:1.0f];
        [RCMBHUDTool hideshowIndicator];
    }];
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photoCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AAAA" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [self.choiceImageViewArray[indexPath.item] image];
    cell.backgroundView = imageView;
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    _photoPageControl.currentPage = scrollView.contentOffset.x / 200;
}

@end
