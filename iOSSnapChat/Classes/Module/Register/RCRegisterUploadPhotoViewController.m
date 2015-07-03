//
//  RCRegisterUploadPhotoViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/11.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCRegisterUploadPhotoViewController.h"
#import "RCRegisterUploadPhotoCollectionViewCell.h"
#import "RCLoginViewController.h"
#import "RCBaseNavgationController.h"
#import "RCLoginAutoModel.h"
#import "RCMainLikeViewController.h"

typedef NS_ENUM(NSInteger, kRCCamerGalleryTapType) {
    kRCCamerGalleryTapTypeReplace = 0,
    kRCCamerGalleryTapTypeAdd
};

#define kRRegisterUploadButtonTotalCount 3
#define kRRegisterUploadCollectionViewCellReuseIdentifier @"kRRegisterUploadCollectionViewCellReuseIdentifier"
#define kRRegisterUploadCollectionViewCornerRadius 10
#define kRRegisterUploadAddButtonBorderWidth 1
#define kRRegisterUploadPageLabelCornerRadius 5

//主界面约束
#define kRCRegisterInfoPhotoCollectionViewTopConstant (kRCAdaptationHeight(44) + 64)
#define kRCRegisterInfoPhotoCollectionViewLeftConstant kRCAdaptationWidth(110)
#define kRCRegisterInfoPhotoCollectionViewWidthConstant (kRCScreenWidth - kRCAdaptationWidth(110) * 2)
#define kRCRegisterInfoPhotoCollectionViewHeightConstant (kRCScreenWidth - kRCAdaptationWidth(110) * 2)

#define kRCRegisterInfoPageLabelBottomConstant 5
#define kRCRegisterInfoPageLabelRightConstant 5
#define kRCRegisterInfoPageLabelWidthConstant 40
#define kRCRegisterInfoPageLabelHeightConstant 15

#define kRCRegisterInfoPhotoMargin 10

#define kRCRegisterInfoFirstAddPhotoImagageViewTopConstant kRCAdaptationHeight(38)
#define kRCRegisterInfoFirstAddPhotoImagageViewLeftConstant kRCAdaptationWidth(60)
#define kRCRegisterInfoFirstAddPhotoImagageViewWidthConstant ((kRCScreenWidth - kRCRegisterInfoPhotoMargin * 2 - kRCRegisterInfoFirstAddPhotoImagageViewLeftConstant * 2) / 3)
#define kRCRegisterInfoFirstAddPhotoImagageViewHeightConstant ((kRCScreenWidth - kRCRegisterInfoPhotoMargin * 2 - kRCRegisterInfoFirstAddPhotoImagageViewLeftConstant * 2) / 3)

#define kRCRegisterInfoNotFirstAddPhotoImagageViewTopConstant kRCAdaptationHeight(38)
#define kRCRegisterInfoNotFirstAddPhotoImagageViewLeftConstant kRCRegisterInfoPhotoMargin
#define kRCRegisterInfoNotFirstAddPhotoImagageViewWidthConstant ((kRCScreenWidth - kRCRegisterInfoPhotoMargin * 2 - kRCRegisterInfoFirstAddPhotoImagageViewLeftConstant * 2) / 3)
#define kRCRegisterInfoNotFirstAddPhotoImagageViewHeightConstant ((kRCScreenWidth - kRCRegisterInfoPhotoMargin * 2 - kRCRegisterInfoFirstAddPhotoImagageViewLeftConstant * 2) / 3)

#define kRCRegisterInfoMsgLabelTopConstant 20
#define kRCRegisterInfoMsgLabelLeftConstant kRCAdaptationWidth(22)
#define kRCRegisterInfoMsgLabelRightConstant kRCAdaptationWidth(22)

#define kRCRegisterInfoGoButtonTopConstant kRCAdaptationHeight(88)
#define kRCRegisterInfoGoButtonLeftConstant kRCAdaptationWidth(22)
#define kRCRegisterInfoGoButtonRightConstant kRCAdaptationWidth(22)
#define kRCRegisterInfoGoButtonHeightConstant kRCAdaptationHeight(78)

@interface RCRegisterUploadPhotoViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    //Control
    UICollectionView *_photoCollectionView;
    UILabel *_pageLabel;
    UILabel *_msgLabel;
    UIButton *_goButton;
    
    NSInteger _photoCount;
    NSInteger _tapIndex;
    NSInteger _uploadIndex;
    kRCCamerGalleryTapType _currentTapType;
    NSMutableArray *_judgeImageFillArray;
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
    
    [self initData];
    [self inheritSetting];
    [self setUpUI];
    [self addConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Utility
- (void)initData {
    _judgeImageFillArray = [NSMutableArray arrayWithArray:@[@YES, @NO, @NO]];
    _photoCount = 1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kRCDefaultBackWhiteColor;
}

- (void)inheritSetting {
    self.title = kRCLocalizedString(@"RegisterUploadPhotoNavigationUploadTitle");
}

- (void)setUpUI {
    UICollectionViewFlowLayout *photoCollectLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:photoCollectLayout];
    photoCollectionView.backgroundColor = [UIColor redColor];
    photoCollectionView.layer.cornerRadius = kRRegisterUploadCollectionViewCornerRadius;
    photoCollectionView.layer.masksToBounds = YES;
    photoCollectLayout.itemSize = CGSizeMake(kRCRegisterInfoPhotoCollectionViewWidthConstant, kRCRegisterInfoPhotoCollectionViewHeightConstant);
    photoCollectLayout.minimumLineSpacing = 0;
    photoCollectLayout.minimumInteritemSpacing = 0;
    photoCollectionView.bounces = NO;
    photoCollectLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    photoCollectionView.showsHorizontalScrollIndicator = NO;
    photoCollectionView.pagingEnabled = YES;
    photoCollectionView.backgroundColor = [UIColor whiteColor];
    [photoCollectionView registerClass:[RCRegisterUploadPhotoCollectionViewCell class] forCellWithReuseIdentifier:kRRegisterUploadCollectionViewCellReuseIdentifier];
    photoCollectionView.dataSource = self;
    photoCollectionView.delegate = self;
    [self.view addSubview:photoCollectionView];
    _photoCollectionView = photoCollectionView;
    
    UILabel *pageLabel = [[UILabel alloc] init];
    pageLabel.font = kRCSystemFont(17);
    pageLabel.backgroundColor = kRCDefaultAlphaBlack;
    pageLabel.textColor = kRCDefaultWhite;
    pageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:pageLabel];
    pageLabel.text = [NSString stringWithFormat:@"%d/%d", 1, _photoCount];
    pageLabel.layer.cornerRadius = kRRegisterUploadPageLabelCornerRadius;
    pageLabel.layer.masksToBounds = YES;
    _pageLabel = pageLabel;
    
    for (int i = 0; i < kRRegisterUploadButtonTotalCount; ++ i) {
        UIImageView *addPhotoImageView = [[UIImageView alloc] initWithImage:kRCImage(@"kongbai")];
        addPhotoImageView.layer.borderWidth = kRRegisterUploadAddButtonBorderWidth;
        addPhotoImageView.layer.borderColor = kRCSystemLightgray.CGColor;
        addPhotoImageView.userInteractionEnabled = YES;
        addPhotoImageView.tag = i;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotoImageDidTap:)];
        [addPhotoImageView addGestureRecognizer:tapRecognizer];
        if (i == 0) {
            [addPhotoImageView setImage:_selectedPassPhoto];
            kAcquireUserDefaultUsertoken
            NSData *uploadImageDataOne = UIImageJPEGRepresentation(_selectedPassPhoto, 1.0f);
            [RCMBHUDTool showIndicator];
            [[RCNetworkManager shareManager] POSTRequest:@"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/Regi3.do?method=upload" parameters:@{@"plat": @1, @"usertoken": usertoken, @"index": @1} upateFileData:uploadImageDataOne success:^(id responseObject) {
                NSDictionary *result = (NSDictionary *)responseObject;
                [userDefault setInteger:[result[@"step"] intValue] forKey:kRCUserDefaultResgisterStepKey];
                [RCMBHUDTool hideshowIndicator];
                [RCMBHUDTool showText:@"完成上传第1张" hideDelay:1.0f];
            } failure:^(NSError *error) {
                [RCMBHUDTool showText:@"上传失败" hideDelay:1.0f];
                [self.navigationController popViewControllerAnimated:YES];
                [RCMBHUDTool hideshowIndicator];
            }];
        }
        if (i == 2) addPhotoImageView.hidden = YES;
        [self.view addSubview:addPhotoImageView];
        [self.addPhotoImagageViewArray addObject:addPhotoImageView];
    }
    
    UILabel *msgLabel = [[UILabel alloc] init];
    msgLabel.textColor = kRCDefaultAlphaBlack;
    msgLabel.font = kRCSystemFont(16);
    msgLabel.numberOfLines = 0;
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.text = kRCLocalizedString(@"RegisterUploadPhotoDescriptionTitle");
    [self.view addSubview:msgLabel];
    _msgLabel = msgLabel;
    
    UIButton *goButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goButton setBackgroundColor:kRCDefaultBlue];
    [goButton setTitle:@"Go" forState:UIControlStateNormal];
    [goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goButton addTarget:self action:@selector(goButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goButton];
    _goButton = goButton;
}

- (void)addConstraint {
    [_photoCollectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_photoCollectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:kRCRegisterInfoPhotoCollectionViewTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_photoCollectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCRegisterInfoPhotoCollectionViewLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_photoCollectionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoPhotoCollectionViewWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_photoCollectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoPhotoCollectionViewHeightConstant]];
    
    [_pageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_pageLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_photoCollectionView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kRCRegisterInfoPageLabelBottomConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_pageLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_photoCollectionView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-kRCRegisterInfoPageLabelRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_pageLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoPageLabelWidthConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_pageLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoPageLabelHeightConstant]];
    
    [self.addPhotoImagageViewArray enumerateObjectsUsingBlock:^(UIImageView *addPhotoImageView, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
            [addPhotoImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_photoCollectionView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCRegisterInfoFirstAddPhotoImagageViewTopConstant]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCRegisterInfoFirstAddPhotoImagageViewLeftConstant]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoFirstAddPhotoImagageViewWidthConstant]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoFirstAddPhotoImagageViewHeightConstant]];
        } else {
            [addPhotoImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_photoCollectionView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCRegisterInfoFirstAddPhotoImagageViewTopConstant]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.addPhotoImagageViewArray[idx - 1] attribute:NSLayoutAttributeRight multiplier:1.0 constant:kRCRegisterInfoNotFirstAddPhotoImagageViewLeftConstant]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoNotFirstAddPhotoImagageViewWidthConstant]];
            [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addPhotoImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoNotFirstAddPhotoImagageViewHeightConstant]];
        }
    }];
    
    [_msgLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_msgLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.addPhotoImagageViewArray.lastObject attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCRegisterInfoMsgLabelTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_msgLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCRegisterInfoMsgLabelLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_msgLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCRegisterInfoMsgLabelRightConstant]];
    
    [_goButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_goButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_msgLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kRCRegisterInfoGoButtonTopConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_goButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:kRCRegisterInfoGoButtonLeftConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_goButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-kRCRegisterInfoGoButtonRightConstant]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_goButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kRCRegisterInfoGoButtonHeightConstant]];
}

#pragma mark - Action
- (void)arrowBackDidClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addPhotoImageDidTap:(UITapGestureRecognizer *)recognizer {
    UIImageView *tapImageView = (UIImageView *)recognizer.view;
    _tapIndex = tapImageView.tag;
    if ([_judgeImageFillArray[_tapIndex] boolValue] == YES) {
        _currentTapType = kRCCamerGalleryTapTypeReplace;
        _uploadIndex = _tapIndex + 1;
    } else {
        _currentTapType = kRCCamerGalleryTapTypeAdd;
        _uploadIndex = _photoCount + 1;
    }
    UIAlertController *uploadAlertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:kRCLocalizedString(@"RegisterUploadPhotoCameraActionTitle") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acquireCamaraGalleryPhoto:) name:kRCCameraGalleryNotification object:nil];
        [[RCCamerGalleryManager shareManager] openCameraAcquirePhotoWithCurrentViewController:self];
    }];
    
    UIAlertAction *galleryAction = [UIAlertAction actionWithTitle:kRCLocalizedString(@"RegisterUploadPhotoGalleryActionTitle") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
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
    if (_currentTapType == kRCCamerGalleryTapTypeReplace) {
        UIImageView *currentTapImageView = [_addPhotoImagageViewArray objectAtIndex:_tapIndex];
        currentTapImageView.image = selectedPhoto;
    } else if (_currentTapType == kRCCamerGalleryTapTypeAdd) {
        if (_photoCount == 1) {
#warning 实现动画 同时需要把图片改变的情况放入到图片上传成功的block中
            UIImageView *imageView = (UIImageView *)self.addPhotoImagageViewArray[2];
            imageView.hidden = NO;
        }
        UIImageView *currentTapImageView = [_addPhotoImagageViewArray objectAtIndex:_photoCount];
        _photoCount += 1;
        currentTapImageView.image = selectedPhoto;
    }
    
    //上传图片
    kAcquireUserDefaultUsertoken
    NSData *uploadImageDataOne = UIImageJPEGRepresentation(selectedPhoto, 1.0f);
    [RCMBHUDTool showIndicator];
    [[RCNetworkManager shareManager] POSTRequest:@"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/Regi3.do?method=upload" parameters:@{@"plat": @1, @"usertoken": usertoken, @"index": @(_uploadIndex)} upateFileData:uploadImageDataOne success:^(id responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
        [userDefault setInteger:[result[@"step"] intValue] forKey:kRCUserDefaultResgisterStepKey];
        [RCMBHUDTool hideshowIndicator];
        [RCMBHUDTool showText:[NSString stringWithFormat:@"完成上传第%d张", _uploadIndex] hideDelay:1.0f];

        [_judgeImageFillArray replaceObjectAtIndex:_tapIndex withObject:@YES];
        //刷新显示数据
        _pageLabel.text = [NSString stringWithFormat:@"%d/%d", (int)(_photoCollectionView.contentOffset.x / (kRCScreenWidth - 110)) + 1, _photoCount];
        [_photoCollectionView reloadData];
    } failure:^(NSError *error) {
        [RCMBHUDTool showText:@"上传失败" hideDelay:1.0f];
        [RCMBHUDTool hideshowIndicator];
    }];
}

- (void)goButtonDidClick {
    [RCMBHUDTool showIndicator];
    kAcquireUserDefaultAll
    
    //自动登录
    RCLoginAutoModel *loginAutoModel = [[RCLoginAutoModel alloc] init];
    loginAutoModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/AutoLogin.do";
    loginAutoModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    loginAutoModel.parameters = @{@"plat": @1,
                                  @"usertoken": usertoken,
                                  @"countryid": coutryID,
                                  @"cityid": cityID,
                                  @"lon": @(longitude),
                                  @"lat": @(latitude),
                                  @"pushtoken": pushtoken
                                  };
    
    [loginAutoModel requestServerWithModel:loginAutoModel success:^(id resultModel) {
        RCLoginAutoModel *result = (RCLoginAutoModel *)resultModel;
        if ([result.mess isEqualToString:@"succ"]) {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:@"自动登录完成" hideDelay:1];
            [self enterApplicationMain:result.userInfo];
        } else {
            [RCMBHUDTool hideshowIndicator];
            [RCMBHUDTool showText:@"usertoken过期/连接超时,请手动登陆" hideDelay:1];
            [[NSNotificationCenter defaultCenter] postNotificationName:kRCSwitchRootVcNotification object:nil userInfo:@{kRCSwitchRootVcNotificationStepKey: @0, kRCSwitchRootVcNotificationVcKey: self.navigationController}];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)enterApplicationMain:(RCUserInfoModel *)userInfo {
    RCMainLikeViewController *mainLikeVc = [[RCMainLikeViewController alloc] init];
    mainLikeVc.loginUserInfo = userInfo;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainLikeVc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photoCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RCRegisterUploadPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRRegisterUploadCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    UIImageView *addPhotoImageView = _addPhotoImagageViewArray[indexPath.item];
    cell.drawImage = addPhotoImageView.image;
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _pageLabel.text = [NSString stringWithFormat:@"%d/%d", (int)(_photoCollectionView.contentOffset.x / (kRCScreenWidth - 110)) + 1, _photoCount];
}

@end
