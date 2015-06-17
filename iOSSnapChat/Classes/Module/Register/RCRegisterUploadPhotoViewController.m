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

#define kRRegisterUploadCollectionViewCellReuseIdentifier @"kRRegisterUploadCollectionViewCellReuseIdentifier"

#import "RCRegisterUploadPhotoViewController.h"
#import "RCRegisterUploadPhotoCollectionViewCell.h"

@interface RCRegisterUploadPhotoViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    UICollectionView *_photoCollectionView;
    //所有的图片数
    NSInteger _photoCount;
    //点击的图片索引
    NSInteger _tapIndex;
    //上传的图片索引
    NSInteger _uploadIndex;
    //当前图片点击类型
    kRCCamerGalleryTapType _currentTapType;
    //计数器
    UIPageControl *_photoPageControl;
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
    //关闭自动调节,避免尺寸错误
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //照片
    _photoCount = 1;
    UICollectionViewFlowLayout *photoCollectLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(60, 64 + 10, kRCScreenWidth - 120, kRCScreenWidth - 120) collectionViewLayout:photoCollectLayout];
    photoCollectionView.layer.cornerRadius = 5;
    photoCollectionView.layer.masksToBounds = YES;
    photoCollectLayout.itemSize = CGSizeMake(kRCScreenWidth - 120, kRCScreenWidth - 120);
    photoCollectLayout.minimumLineSpacing = 0;
    photoCollectLayout.minimumInteritemSpacing = 0;
    photoCollectLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    photoCollectionView.showsHorizontalScrollIndicator = NO;
    photoCollectionView.pagingEnabled = YES;
    photoCollectionView.backgroundColor = [UIColor whiteColor];
    [photoCollectionView registerClass:[RCRegisterUploadPhotoCollectionViewCell class] forCellWithReuseIdentifier:kRRegisterUploadCollectionViewCellReuseIdentifier];
    photoCollectionView.dataSource = self;
    photoCollectionView.delegate = self;
    [self.view addSubview:photoCollectionView];
    _photoCollectionView = photoCollectionView;
    
    //照片计数器
    UIPageControl *photoPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(60 + (photoCollectionView.bounds.size.width - 100) * 0.5, CGRectGetMaxY(_photoCollectionView.frame) - 37, 100, 37)];
    photoPageControl.numberOfPages = _photoCount;
    [self.view addSubview:photoPageControl];
    _photoPageControl = photoPageControl;
    
    //添加照片按钮
    for (int i = 0; i < 3; ++ i) {
        UIImageView *addPhotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + (kRCScreenWidth - 20 - 20 - 10 - 10) / 3 * i + 10 * i, CGRectGetMaxY(photoCollectionView.frame) + 10, (kRCScreenWidth - 20 - 20 - 10 - 10) / 3, (kRCScreenWidth - 20 - 20 - 10 - 10) / 3)];
        addPhotoImageView.layer.borderWidth = 1;
        addPhotoImageView.layer.cornerRadius = 2;
        addPhotoImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        addPhotoImageView.layer.masksToBounds = YES;
        addPhotoImageView.contentMode = UIViewContentModeScaleAspectFit;
        addPhotoImageView.userInteractionEnabled = YES;
        addPhotoImageView.tag = i;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotoImageDidTap:)];
        [addPhotoImageView addGestureRecognizer:tapRecognizer];
        if (i == 0) {
            [addPhotoImageView setImage:_selectedPassPhoto];
            //上传第一张图片
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSString *usertoken = [userDefault stringForKey:kRCUserDefaultUserTokenKey];
            NSData *uploadImageDataOne = UIImageJPEGRepresentation(_selectedPassPhoto, 1.0f);
            [RCMBHUDTool showIndicator];
            [[RCNetworkManager shareManager] POSTRequest:@"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/Regi3.do?method=upload" parameters:@{@"plat": @1, @"usertoken": usertoken, @"index": @1} upateFileData:uploadImageDataOne success:^(id responseObject) {
                [RCMBHUDTool hideshowIndicator];
                [RCMBHUDTool showText:@"完成上传第1张" hideDelay:1.0f];
            } failure:^(NSError *error) {
                [RCMBHUDTool showText:@"上传失败" hideDelay:1.0f];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        if (i == 2) addPhotoImageView.hidden = YES;
        [self.view addSubview:addPhotoImageView];
        [self.addPhotoImagageViewArray addObject:addPhotoImageView];
    }
    
    //描述文本
    NSString *descriptionText = @"OK! cool! Upload more photos will increase your chances of find friends!";
    CGSize size = [descriptionText sizeForLineWithSize:CGSizeMake(kRCScreenWidth - 40, MAXFLOAT) Attributes:@{NSFontAttributeName: kRCSystemFont(14)}];
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(photoCollectionView.frame) + 10 + (kRCScreenWidth - 20 - 20 - 10 - 10) / 3 + 10, size.width, size.height)];
    msgLabel.font = kRCSystemFont(14);
    msgLabel.numberOfLines = 0;
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.text = descriptionText;
    [self.view addSubview:msgLabel];
    
    //Go按钮
    UIButton *goButton = [UIButton buttonWithType:UIButtonTypeCustom];
    goButton.frame = CGRectMake(20, CGRectGetMaxY(msgLabel.frame) + 10, kRCScreenWidth - 40, 44);
    [goButton setBackgroundColor:kRCSystemDefaultBlue];
    [goButton setTitle:@"Go" forState:UIControlStateNormal];
    [goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goButton addTarget:self action:@selector(goButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
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
        _uploadIndex = _tapIndex + 1;
    } else {
        _currentTapType = kRCCamerGalleryTapTypeAdd;
        _uploadIndex = _photoCount + 1;
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
    [self.navigationController popViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    UIImage *selectedPhoto = notice.userInfo[kRCCameraGalleryNotification];
    if (_currentTapType == kRCCamerGalleryTapTypeReplace) {
        UIImageView *currentTapImageView = [_addPhotoImagageViewArray objectAtIndex:_tapIndex];
        currentTapImageView.image = selectedPhoto;
    } else if (_currentTapType == kRCCamerGalleryTapTypeAdd) {
        if (_photoCount == 1) {
            NSLog(@"动画");
            UIImageView *imageView = (UIImageView *)self.addPhotoImagageViewArray[2];
            imageView.hidden = NO;
        }
        
        UIImageView *currentTapImageView = [_addPhotoImagageViewArray objectAtIndex:_photoCount];
        _photoCount += 1;
        currentTapImageView.image = selectedPhoto;
    }
    
    //上传图片
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *usertoken = [userDefault stringForKey:kRCUserDefaultUserTokenKey];
    NSData *uploadImageDataOne = UIImageJPEGRepresentation(selectedPhoto, 1.0f);
    [RCMBHUDTool showIndicator];
    [[RCNetworkManager shareManager] POSTRequest:@"http://192.168.0.88:8088/ExcavateSnapchatWeb/userinfo/Regi3.do?method=upload" parameters:@{@"plat": @1, @"usertoken": usertoken, @"index": @(_uploadIndex)} upateFileData:uploadImageDataOne success:^(id responseObject) {
        [RCMBHUDTool hideshowIndicator];
        [RCMBHUDTool showText:[NSString stringWithFormat:@"完成上传第%d张", _uploadIndex] hideDelay:1.0f];
        //刷新显示数据
        _photoPageControl.numberOfPages = _photoCount;
        [_photoCollectionView reloadData];
    } failure:^(NSError *error) {
        [RCMBHUDTool showText:@"上传失败" hideDelay:1.0f];
    }];
}

- (void)goButtonDidClick {
    NSLog(@"Go");
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
    _photoPageControl.currentPage = scrollView.contentOffset.x / 200;
}

@end
