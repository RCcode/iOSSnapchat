//
//  RCMainLikeModifyPhotoViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/25.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeModifyPhotoViewController.h"
#import "RCUserInfoModel.h"

#define kRCMainLikeModifyPhotoButtonTotalCount 3
#define kRCMainLikeModifyPhotoCollectionViewCellReuseIdentifier @"kRCMainLikeModifyPhotoCollectionViewCellReuseIdentifier"

//主界面约束
#define kRCMainLikeModifyPhotoPhotoCollectionViewTopConstant (kRCAdaptationHeight(44) + 64)
#define kRCMainLikeModifyPhotoCollectionViewLeftConstant kRCAdaptationWidth(110)
#define kRCMainLikeModifyPhotoCollectionViewWidthConstant (kRCScreenWidth - kRCAdaptationWidth(110) * 2)
#define kRCMainLikeModifyPhotoCollectionViewHeightConstant (kRCScreenWidth - kRCAdaptationWidth(110) * 2)

#define kRCMainLikeModefiyPhotoIndexLabelBottomConstant 10
#define kRCMainLikeModefiyPhotoIndexLabelRightConstant 10
#define kRCMainLikeModefiyPhotoIndexLabelWidthConstant 40
#define kRCMainLikeModefiyPhotoIndexLabelHeightConstant 15

#define kRCMainLikeModifyPhotoPhotoMargin 10

#define kRCMainLikeModifyPhotoFirstChoiceImageViewTopConstant kRCAdaptationHeight(38)
#define kRCMainLikeModifyPhotoFirstChoiceImageViewLeftConstant kRCAdaptationWidth(60)
#define kRCMainLikeModifyPhotoFirstChoiceImageViewWidthConstant ((kRCScreenWidth - kRCMainLikeModifyPhotoPhotoMargin * 2 - kRCMainLikeModifyPhotoFirstChoiceImageViewLeftConstant * 2) / 3)
#define kRCMainLikeModifyPhotoFirstChoiceImageViewHeightConstant ((kRCScreenWidth - kRCMainLikeModifyPhotoPhotoMargin * 2 - kRCMainLikeModifyPhotoFirstChoiceImageViewLeftConstant * 2) / 3)

#define kRCMainLikeModifyPhotoNotFirstChoiceImageViewTopConstant kRCAdaptationHeight(38)
#define kRCMainLikeModifyPhotoNotFirstChoiceImageViewLeftConstant kRCMainLikeModifyPhotoPhotoMargin
#define kRCMainLikeModifyPhotoNotFirstChoiceImageViewWidthConstant ((kRCScreenWidth - kRCMainLikeModifyPhotoPhotoMargin * 2 - kRCMainLikeModifyPhotoFirstChoiceImageViewLeftConstant * 2) / 3)
#define kRCMainLikeModifyPhotoNotFirstChoiceImageViewHeightConstant ((kRCScreenWidth - kRCMainLikeModifyPhotoPhotoMargin * 2 - kRCMainLikeModifyPhotoFirstChoiceImageViewLeftConstant * 2) / 3)

typedef NS_ENUM(NSInteger, kRCCamerGalleryTapType) {
    kRCCamerGalleryTapTypeReplace = 0,
    kRCCamerGalleryTapTypeAdd
};

@interface RCMainLikeModifyPhotoViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    //MainUI
    UICollectionView *_photoCollectionView;
    UILabel *_indexLabel;
    NSMutableArray *_judgeImageFillArray;
    
    NSInteger _photoCount;
    kRCCamerGalleryTapType _currentTapType;
    NSInteger _tapIndex;
    NSInteger _uploadIndex;
    
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
    
    [self initData];
    [self setUpUI];
    [self addConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility
- (void)initData {
    [self acquirePhotoCountAndJudgeArray:self.userInfo];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setUpUI {
    UICollectionViewFlowLayout *photoCollectLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:photoCollectLayout];
    photoCollectionView.bounces = NO;
    photoCollectionView.layer.cornerRadius = 5;
    photoCollectionView.layer.masksToBounds = YES;
    photoCollectLayout.itemSize = CGSizeMake(kRCMainLikeModifyPhotoCollectionViewWidthConstant, kRCMainLikeModifyPhotoCollectionViewHeightConstant);
    photoCollectLayout.minimumLineSpacing = 0;
    photoCollectLayout.minimumInteritemSpacing = 0;
    photoCollectLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    photoCollectionView.showsHorizontalScrollIndicator = NO;
    photoCollectionView.pagingEnabled = YES;
    photoCollectionView.backgroundColor = [UIColor whiteColor];
    [photoCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kRCMainLikeModifyPhotoCollectionViewCellReuseIdentifier];
    photoCollectionView.dataSource = self;
    photoCollectionView.delegate = self;
    [self.view addSubview:photoCollectionView];
    _photoCollectionView = photoCollectionView;
    
    UILabel *indexLabel = [[UILabel alloc] init];
    indexLabel.layer.cornerRadius = 5;
    indexLabel.layer.masksToBounds = YES;
    indexLabel.font = kRCSystemFont(14);
    indexLabel.textAlignment = NSTextAlignmentCenter;
    indexLabel.backgroundColor = kRCDefaultAlphaBlack;
    indexLabel.textColor = kRCDefaultWhite;
    indexLabel.text = [NSString stringWithFormat:@"%d/%d", 1, [self acquirePhotoCount:self.userInfo]];
    [self.view addSubview:indexLabel];
    _indexLabel = indexLabel;
    
    for (int i = 0; i < kRCMainLikeModifyPhotoButtonTotalCount; ++ i) {
        UIImageView *choiceImageView = [[UIImageView alloc] init];
        choiceImageView.tag = i;
        choiceImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizerDidTap:)];
        [choiceImageView addGestureRecognizer:tapRecognizer];
        [self.view addSubview:choiceImageView];
        [self.choiceImageViewArray addObject:choiceImageView];
        switch (i) {
            case 0: {
                [choiceImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.url1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [_photoCollectionView reloadData];
                }];
            }
                break;
            case 1: {
                [choiceImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.url2] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if ([self.userInfo.url2 isEqualToString:@""]) {
                        UIImageView *imgV = self.choiceImageViewArray[1];
                        imgV.image = kRCImage(@"kongbai");
                    } else {
                        [_photoCollectionView reloadData];
                    }
                }];
            }
                break;
            case 2: {
                [choiceImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.url3] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if ([self.userInfo.url3 isEqualToString:@""]) {
                        UIImageView *imgV = self.choiceImageViewArray[2];
                        imgV.image = kRCImage(@"kongbai");
                    } else {
                        [_photoCollectionView reloadData];
                    }
                }];
            }
                break;
            default:
                break;
        }
    }
}

- (void)addConstraint {
    [_photoCollectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_photoCollectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCMainLikeModifyPhotoPhotoCollectionViewTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_photoCollectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeModifyPhotoCollectionViewLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_photoCollectionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeModifyPhotoCollectionViewWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_photoCollectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeModifyPhotoCollectionViewHeightConstant]];
    
    [_indexLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_photoCollectionView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCMainLikeModefiyPhotoIndexLabelBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_photoCollectionView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCMainLikeModefiyPhotoIndexLabelRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeModefiyPhotoIndexLabelWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_indexLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeModefiyPhotoIndexLabelHeightConstant]];
    
    [self.choiceImageViewArray enumerateObjectsUsingBlock:^(UIImageView *addPhotoImageView, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
            [addPhotoImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_photoCollectionView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCMainLikeModifyPhotoFirstChoiceImageViewTopConstant]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCMainLikeModifyPhotoFirstChoiceImageViewLeftConstant]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeModifyPhotoFirstChoiceImageViewWidthConstant]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeModifyPhotoFirstChoiceImageViewHeightConstant]];
        } else {
            [addPhotoImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_photoCollectionView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCMainLikeModifyPhotoNotFirstChoiceImageViewTopConstant]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.choiceImageViewArray[idx - 1] attribute:NSLayoutAttributeRight multiplier:1.0 constant:kRCMainLikeModifyPhotoNotFirstChoiceImageViewLeftConstant]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeModifyPhotoNotFirstChoiceImageViewWidthConstant]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCMainLikeModifyPhotoNotFirstChoiceImageViewHeightConstant]];
        }
    }];
    
}

- (void)acquirePhotoCountAndJudgeArray:(RCUserInfoModel *)userInfo {
    if (![userInfo.url3 isEqualToString:@""]) {
        _photoCount = 3;
        _judgeImageFillArray = [NSMutableArray arrayWithArray:@[@YES, @YES, @YES]];
    } else if (![userInfo.url2 isEqualToString:@""]) {
        _photoCount = 2;
        _judgeImageFillArray = [NSMutableArray arrayWithArray:@[@YES, @YES, @NO]];
    } else if (![userInfo.url1 isEqualToString:@""]) {
        _photoCount = 1;
        _judgeImageFillArray = [NSMutableArray arrayWithArray:@[@YES, @NO, @NO]];
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
    _tapIndex = recognizer.view.tag;
    if ([_judgeImageFillArray[_tapIndex] boolValue] == YES) {
        _currentTapType = kRCCamerGalleryTapTypeReplace;
        _uploadIndex = _tapIndex + 1;
    } else {
        _currentTapType = kRCCamerGalleryTapTypeAdd;
        _uploadIndex = _photoCount + 1;
    }
    UIAlertController *uploadAlertVc = [[UIAlertController alloc] init];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:kRCLocalizedString(@"MainLikeModifyPhotoTitleCamera") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acquireCamaraGalleryPhoto:) name:kRCCameraGalleryNotification object:nil];
        [[RCCamerGalleryManager shareManager] openCameraAcquirePhotoWithCurrentViewController:self];
    }];
    UIAlertAction *galleryAction = [UIAlertAction actionWithTitle:kRCLocalizedString(@"MainLikeModifyPhotoTitleGallery") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
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
    if (_tapIndex == 0) {
        _showImage = selectedPhoto;
    }
    
    kAcquireUserDefaultUsertoken
    NSData *uploadImageDataOne = UIImageJPEGRepresentation(selectedPhoto, 1.0f);
    [RCMBHUDTool showIndicator];
    [[RCNetworkManager shareManager] POSTRequest:[Global shareGlobal].registerUploadPhotoURLString parameters:@{@"plat": @1,
                                                                                                                @"usertoken": usertoken,
                                                                                                                @"index": @(_uploadIndex)}
                                   upateFileData:uploadImageDataOne success:^(id responseObject) {
                                       NSDictionary *result = (NSDictionary *)responseObject;
                                       int errorCode = [result[@"state"] intValue];
                                       if (errorCode == 10000) {
                                           [RCMBHUDTool hideshowIndicator];
                                           [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeUploadImageErrorCodeSucc") hideDelay:1];
                                           [_judgeImageFillArray replaceObjectAtIndex:_uploadIndex - 1 withObject:@YES];
                                           [_photoCollectionView reloadData];
                                           _indexLabel.text = [NSString stringWithFormat:@"%d/%d", (int)(_photoCollectionView.contentOffset.x / (kRCScreenWidth - kRCMainLikeModifyPhotoCollectionViewLeftConstant * 2)) + 1, _photoCount];
                                           UIImageView *currentTapImageView = nil;
                                           if (_currentTapType == kRCCamerGalleryTapTypeReplace) {
                                               currentTapImageView = [_choiceImageViewArray objectAtIndex:_tapIndex];
                                               currentTapImageView.image = selectedPhoto;
                                           } else if (_currentTapType == kRCCamerGalleryTapTypeAdd) {
                                               currentTapImageView = [_choiceImageViewArray objectAtIndex:_photoCount];
                                               currentTapImageView.image = selectedPhoto;
                                               _photoCount += 1;
                                           }
                                       }else if (errorCode == 10004) {
                                           [RCMBHUDTool hideshowIndicator];
                                           [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeUploadImageErrorCodeUsertokenError") hideDelay:1.0f];
                                       } else {
                                           [RCMBHUDTool hideshowIndicator];
                                           [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeUploadImageErrorCodeCannotConnectServer") hideDelay:1.0f];
                                       }
                                       
                                   } failure:^(NSError *error) {
                                       [RCMBHUDTool hideshowIndicator];
                                       [RCMBHUDTool showText:kRCLocalizedString(@"MainLikeUploadImageErrorCodeNetworkError") hideDelay:1.0f];
                                   }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photoCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRCMainLikeModifyPhotoCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [self.choiceImageViewArray[indexPath.item] image];
    cell.backgroundView = imageView;
    return cell;
}


//    _photoPageControl.currentPage = scrollView.contentOffset.x / 200;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _indexLabel.text = [NSString stringWithFormat:@"%d/%d", (int)(scrollView.contentOffset.x / (kRCScreenWidth - kRCMainLikeModifyPhotoCollectionViewLeftConstant * 2)) + 1, _photoCount];
}

@end

