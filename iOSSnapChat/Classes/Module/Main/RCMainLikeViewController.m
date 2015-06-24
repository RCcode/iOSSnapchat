//
//  RCMainLikeViewController.m
//  iOSSnapChat
//
//  Created by zhao liang on 15/6/17.
//  Copyright (c) 2015年 gongtao. All rights reserved.
//

#import "RCMainLikeViewController.h"
#import "RCMainMatchModel.h"
#import "RCMainLikeModel.h"
#import "RCMainLikeCollectionViewCell.h"
#import "RCMainLikeTableViewCell.h"
#import "RCMainLikePhotoDetailViewController.h"

#define kRCMainLikeActionAnimationKey @"kRCMainLikeActionAnimationKey"
#define kRMainLikeCollectionViewCellReuseIdentifier @"kRMainLikeCollectionViewCellReuseIdentifier"
#define kRCMainLikeMenuTableViewCellIdentifer @"kRCMainLikeMenuTableViewCellIdentifer"

typedef NS_ENUM(NSInteger, kRCMainLikeType) {
    kRCMainLikeTypeUnlike = 0,
    kRCMainLikeTypeLike
};

typedef struct {
    float longitude;
    float latitude;
}RCLocation;



@interface RCMainLikeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    BOOL _isMainLikeMenuViewLazyLoading;
    
    NSMutableArray *_userList;
    NSInteger _currentIndex;


    UIImageView *_backImageView;
    UICollectionView *_likePhotoCollectionView;
    UIImageView *_sexImageView;
    UILabel *_ageLabel;
    UILabel *_distanceLabel;
    UILabel *_indexLabel;
    
    UILabel *_idLabel;
    RCPhotoView *_photoView;
    UITextView *_idTextView;
    UIButton *_editButton;
}

@property (nonatomic, strong) UIView *mainLikeCoverView;
@property (nonatomic, strong) UIView *mainLikeMenuView;
@property (nonatomic, strong) UIView *mainLikeEditCoverView;
@property (nonatomic, strong) UIView *mainLikeEditView;

@end

@implementation RCMainLikeViewController

#pragma mark - LazyLoading
- (UIView *)mainLikeCoverView {
    if (_mainLikeCoverView == nil) {
        UIView *mainLikeCoverView = [[UIView alloc] initWithFrame:kRCScreenBounds];
        mainLikeCoverView.hidden = YES;
        mainLikeCoverView.backgroundColor = [UIColor blackColor];
        mainLikeCoverView.alpha = 0.3;
        [[UIApplication sharedApplication].keyWindow addSubview:mainLikeCoverView];
        _mainLikeCoverView = mainLikeCoverView;
    }
    return _mainLikeCoverView;
}

- (UIView *)mainLikeMenuView {
    if (_mainLikeMenuView == nil) {
        UIView *mainLikeMenuView = [[UIView alloc] init];
        //用户信息
        UIView *userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRCScreenWidth - 40, 200)];
        userInfoView.backgroundColor = [UIColor purpleColor];
        [mainLikeMenuView addSubview:userInfoView];
        
        RCPhotoView *photoView = [[RCPhotoView alloc] init];
        photoView.frame = CGRectMake((kRCScreenWidth - 40) / 3, (200 - (kRCScreenWidth - 40) / 3) / 2 , (kRCScreenWidth - 40) / 3, (kRCScreenWidth - 40) / 3);
        photoView.photoURL = [NSURL URLWithString:self.loginUserInfo.url1];
        [photoView.camaraButton addTarget:self action:@selector(camaraButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        [userInfoView addSubview:photoView];
        _photoView = photoView;
        
        UILabel *idLabel = [[UILabel alloc] initWithFrame:CGRectMake(- (200 - (CGRectGetMaxY(photoView.frame) + 10) - 10 + 10) / 2, CGRectGetMaxY(photoView.frame) + 10, kRCScreenWidth - 40, 200 - (CGRectGetMaxY(photoView.frame) + 10) - 10)];
        idLabel.text = [NSString stringWithFormat:@"ID: %@", self.loginUserInfo.snapchatid];
        idLabel.textColor = [UIColor whiteColor];
        idLabel.textAlignment = NSTextAlignmentCenter;
        [userInfoView addSubview:idLabel];
        _idLabel = idLabel;
        
        CGSize size = [idLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: idLabel.font} context:nil].size;
        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [editButton addTarget:self action:@selector(editButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        editButton.frame = CGRectMake((kRCScreenWidth - 40) / 2 + size.width / 2 + 10 - (200 - (CGRectGetMaxY(photoView.frame) + 10) - 10 + 10) / 2, CGRectGetMaxY(photoView.frame) + 10, 200 - (CGRectGetMaxY(photoView.frame) + 10) - 10, 200 - (CGRectGetMaxY(photoView.frame) + 10) - 10);
        [editButton setBackgroundColor:[UIColor magentaColor]];
        [userInfoView addSubview:editButton];
        _editButton = editButton;
        
        //菜单信息
        UITableView *menuView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, kRCScreenWidth - 40, kRCScreenHeight - 200)];
        [menuView registerClass:[RCMainLikeTableViewCell class] forCellReuseIdentifier:kRCMainLikeMenuTableViewCellIdentifer];
        menuView.separatorStyle = UITableViewCellSeparatorStyleNone;
        menuView.dataSource = self;
        menuView.delegate = self;
        [mainLikeMenuView addSubview:menuView];

        [[UIApplication sharedApplication].keyWindow addSubview:mainLikeMenuView];
        UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerDidSwipe:)];
        swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [mainLikeMenuView addGestureRecognizer:swipeRecognizer];
        
        _mainLikeMenuView = mainLikeMenuView;
    }
    return _mainLikeMenuView;
}

- (UIView *)mainLikeEditCoverView {
    if (_mainLikeEditCoverView == nil) {
        UIView *mainLikeEditCoverView = [[UIView alloc] initWithFrame:kRCScreenBounds];
        mainLikeEditCoverView.hidden = YES;
        mainLikeEditCoverView.backgroundColor = [UIColor blackColor];
        mainLikeEditCoverView.alpha = 0.3;
        [[UIApplication sharedApplication].keyWindow addSubview:mainLikeEditCoverView];
        _mainLikeEditCoverView = mainLikeEditCoverView;
    }
    return _mainLikeEditCoverView;
}

- (UIView *)mainLikeEditView {
    if (_mainLikeEditView == nil) {
        UIView *mainLikeEditView = [[UIView alloc] initWithFrame:CGRectMake(20, kRCScreenHeight / 3, kRCScreenWidth - 40, kRCScreenHeight / 3)];
        mainLikeEditView.backgroundColor = [UIColor lightGrayColor];
        mainLikeEditView.layer.cornerRadius = 10;
        mainLikeEditView.layer.masksToBounds = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:mainLikeEditView];
        
        //snapchat ID
        UILabel *snapchatIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kRCScreenWidth - 40, 20)];
        snapchatIdLabel.textAlignment = NSTextAlignmentCenter;
        snapchatIdLabel.text = @"Your snapchat ID";
        snapchatIdLabel.textColor = [UIColor darkGrayColor];
        [mainLikeEditView addSubview:snapchatIdLabel];
        
        //ID textfield
        UITextView *idTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, kRCScreenHeight / 3 / 2 - 20, kRCScreenWidth - 40, 40)];
        idTextView.backgroundColor = [UIColor lightGrayColor];
        idTextView.font = kRCBoldSystemFont(17);
        idTextView.textAlignment = NSTextAlignmentCenter;
        [mainLikeEditView addSubview:idTextView];
        _idTextView = idTextView;
        
        UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(idTextView.frame) - 1, kRCScreenWidth - 40 - 40, 1)];
        separatorLine.backgroundColor = [UIColor darkGrayColor];
        [mainLikeEditView addSubview:separatorLine];
        
        //cancel
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(0, kRCScreenHeight / 3 - 40, (kRCScreenWidth - 40) / 2, 40);
        [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        [mainLikeEditView addSubview:cancelButton];
        
        //done
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        doneButton.frame = CGRectMake((kRCScreenWidth - 40) / 2, kRCScreenHeight / 3 - 40, (kRCScreenWidth - 40) / 2, 40);
        [doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(doneButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        [mainLikeEditView addSubview:doneButton];
        
        _mainLikeEditView = mainLikeEditView;
    }
    return _mainLikeEditView;
}

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navgationSettings];
    [self loadData];
    [self setUpUI];
    [self addONotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_likePhotoCollectionView.layer removeAnimationForKey:kRCMainLikeActionAnimationKey];
    [_mainLikeCoverView removeFromSuperview];
    [_mainLikeMenuView removeFromSuperview];
    [_mainLikeEditCoverView removeFromSuperview];
    [_mainLikeEditView removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Utility
- (void)navgationSettings {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Snaper";
    
    //Menu
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(0, 0, 44, 44);
    [menuButton setTitle:@"Men" forState:UIControlStateNormal];
    [menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(menuButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];

    //Message
    UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    messageButton.frame = CGRectMake(0, 0, 44, 44);
    [messageButton setTitle:@"msg" forState:UIControlStateNormal];
    [messageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [messageButton addTarget:self action:@selector(messageButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *messageButtonItem = [[UIBarButtonItem alloc] initWithCustomView:messageButton];
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    self.navigationItem.rightBarButtonItem = messageButtonItem;
}

- (void)loadData {
    RCMainMatchModel *mainMatchModel = [[RCMainMatchModel alloc] init];
    mainMatchModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/excavate/ExcavateUser.do";
    mainMatchModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    
    kAcquireUserDefaultUsertoken
    double longitude = [userDefault doubleForKey:kRCUserDefaultLongitudeKey];
    double latitude = [userDefault doubleForKey:kRCUserDefaultLatitudeKey];
    mainMatchModel.parameters = @{@"plat": @1,
                                  @"usertoken": usertoken,
                                  @"gender": self.loginUserInfo.gender,
//                                  @"gender2": self.loginUserInfo.gender2,
                                  @"gender2": @"1",
                                  @"lon": @(longitude),
                                  @"lat": @(latitude),
                                  @"pageno": @1
                                  };
    
    [mainMatchModel requestServerWithModel:mainMatchModel success:^(id resultModel) {
        RCMainMatchModel *result = (RCMainMatchModel *)resultModel;
        if ([result.mess isEqualToString:@"succ"]) {
            //创建缓存
            
            NSLog(@"获取数据成功, 刷新最新数据");
            _userList = result.list;
            [_likePhotoCollectionView reloadData];
            [self reloadInfo];
        } else {
            NSLog(@"usertoken错误");
        }
    } failure:^(NSError *error) {
        NSLog(@"服务器错误");
    }];
}

- (void)setUpUI {
#warning frame
    //背景图片
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 84, kRCScreenWidth - 40, kRCScreenWidth - 40 + 60)];
    backImageView.backgroundColor = [UIColor yellowColor];
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];
    _backImageView = backImageView;
    
    //好友展示
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *likePhotoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kRCScreenWidth - 40, kRCScreenWidth - 40) collectionViewLayout:layout];
    layout.itemSize = CGSizeMake(likePhotoCollectionView.frame.size.width, likePhotoCollectionView.frame.size.height);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    likePhotoCollectionView.pagingEnabled = YES;
    likePhotoCollectionView.showsHorizontalScrollIndicator = NO;
    [likePhotoCollectionView registerClass:[RCMainLikeCollectionViewCell class] forCellWithReuseIdentifier:kRMainLikeCollectionViewCellReuseIdentifier];
    likePhotoCollectionView.dataSource = self;
    likePhotoCollectionView.delegate = self;
    [backImageView addSubview:likePhotoCollectionView];
    _likePhotoCollectionView = likePhotoCollectionView;
    
    //indexLabel
    UILabel *indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRCScreenWidth - 40 - 40, kRCScreenWidth - 40 - 20, 40, 20)];
    [backImageView addSubview:indexLabel];
    _indexLabel = indexLabel;
    
    //Sex
    UIImageView *sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(likePhotoCollectionView.frame) + 20, 20, 20)];
    [backImageView addSubview:sexImageView];
    _sexImageView = sexImageView;
    
    //Age
    UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(sexImageView.frame) + 10, CGRectGetMaxY(likePhotoCollectionView.frame) + 20, 20, 20)];
    [backImageView addSubview:ageLabel];
    _ageLabel = ageLabel;
    
    //Distance
    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRCScreenWidth - 40 - 80 - 20, CGRectGetMaxY(likePhotoCollectionView.frame) + 20, 80, 20)];
    [backImageView addSubview:distanceLabel];
    _distanceLabel = distanceLabel;
    
    //UnLike
    UIButton *unLikeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    unLikeButton.tag = kRCMainLikeTypeUnlike;
    unLikeButton.frame = CGRectMake((kRCScreenWidth - 120 - 20) / 2, CGRectGetMaxY(backImageView.frame) + 20, 60, 60);
    [unLikeButton setTitle:@"UnLike" forState:UIControlStateNormal];
    [unLikeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [unLikeButton addTarget:self action:@selector(choiceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:unLikeButton];
    
    //Like
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.tag = kRCMainLikeTypeLike;
    likeButton.frame = CGRectMake(CGRectGetMaxX(unLikeButton.frame) + 20, CGRectGetMaxY(backImageView.frame) + 20, 60, 60);
    [likeButton setTitle:@"Like" forState:UIControlStateNormal];
    [likeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [likeButton addTarget:self action:@selector(choiceButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeButton];
}

- (void)addONotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHid:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardDidShow:(NSNotification *)notice {
    CGRect keyboardRect = [notice.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.25f animations:^{
        _mainLikeEditView.frame = CGRectMake(20, keyboardRect.origin.y - kRCScreenHeight / 3 - 20, kRCScreenWidth - 40, kRCScreenHeight / 3);
    }];
}

- (void)keyboardDidHid:(NSNotification *)notice {
    _mainLikeEditView.frame = CGRectMake(20, kRCScreenHeight / 3, kRCScreenWidth - 40, kRCScreenHeight / 3);
}

- (void)reloadInfo {
    if (_userList == nil) return;
    RCUserInfoModel *userInfo = _userList[_currentIndex];
    if (userInfo == nil) return;

    if ([userInfo.gender intValue] == 0) {
        _sexImageView.backgroundColor = [UIColor blueColor];
    } else if ([userInfo.gender intValue]== 1) {
        _sexImageView.backgroundColor = [UIColor redColor];
    }
    _ageLabel.text = [NSString stringWithFormat:@"%d", [userInfo.age intValue]];
    _indexLabel.text = [NSString stringWithFormat:@"%d/%d", 1, [self acquirePhotoCount:userInfo]];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    double userLongitude = [userDefault doubleForKey:kRCUserDefaultLongitudeKey];
    double userLatitude = [userDefault doubleForKey:kRCUserDefaultLatitudeKey];
    double choiceLongtitude = [userInfo.lon floatValue];
    double choiceLatitude = [userInfo.lat floatValue];
    
    if (userLongitude == 0 || userLatitude == 0 || choiceLongtitude == 100000 || choiceLatitude == 100000) {
        _distanceLabel.text = @"NULL";
    } else {
        RCLocation fromLocation = {userLongitude, userLatitude};
        RCLocation toLocation = {choiceLongtitude, choiceLatitude};
        _distanceLabel.text = [NSString stringWithFormat:@"%.1f m", [self distanceFromLocation:fromLocation toLocation:toLocation]];
    }
}


- (float)distanceFromLocation:(RCLocation)fromLocation toLocation:(RCLocation)toLocation {
    return sqrt(((fromLocation.longitude - toLocation.longitude) * M_PI * 12656 * cos(((fromLocation.latitude + toLocation.latitude) / 2) * M_PI / 180) / 180 *
                 (fromLocation.longitude - toLocation.longitude) * M_PI * 12656 * cos(((fromLocation.latitude + toLocation.latitude) / 2) * M_PI / 180) / 180) +
                 (((fromLocation.latitude - toLocation.latitude) * M_PI * 12656/180) * ((fromLocation.latitude - toLocation.latitude) * M_PI * 12656 / 180)));
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
- (void)menuButtonDidClick {
    if (!_isMainLikeMenuViewLazyLoading) {
        //第一次懒加载执行
        self.mainLikeCoverView.hidden = YES;
        self.mainLikeMenuView.frame = CGRectMake(- (kRCScreenWidth - 40), 0, kRCScreenWidth - 40, kRCScreenHeight);
        _isMainLikeMenuViewLazyLoading = YES;
    }
    self.mainLikeCoverView.hidden = NO;
    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.3 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _mainLikeMenuView.frame = CGRectMake(0, 0, kRCScreenWidth - 40, kRCScreenHeight);
    } completion:nil];
}

- (void)gestureRecognizerDidSwipe:(UISwipeGestureRecognizer *)recognizer {
    self.mainLikeCoverView.hidden = YES;
    [UIView animateWithDuration:0.5f animations:^{
        self.mainLikeMenuView.frame = CGRectMake(- (kRCScreenWidth - 40), 0, kRCScreenWidth - 40, kRCScreenHeight);
    }];
}

- (void)messageButtonDidClick {
    NSLog(@"MSG");
}

- (void)choiceButtonDidClicked:(UIButton *)sender {
    
    RCUserInfoModel *userInfo = _userList[_currentIndex];
    NSString *usertoken = [[NSUserDefaults standardUserDefaults] stringForKey:kRCUserDefaultUserTokenKey];
    //发送请求
    RCMainLikeModel *mainLikeModel = [[RCMainLikeModel alloc] init];
    mainLikeModel.requestUrl = @"http://192.168.0.88:8088/ExcavateSnapchatWeb/message/LikeUser.do";
    mainLikeModel.modelRequestMethod = kRCModelRequestMethodTypePOST;
    mainLikeModel.parameters = @{@"plat": @1,
                                 @"usertoken": usertoken,
                                 @"userid2": userInfo.userid,
                                 @"type": @(sender.tag)
                                 };
    
    [mainLikeModel requestServerWithModel:mainLikeModel success:^(id resultModel) {
        RCMainLikeModel *result = (RCMainLikeModel *)resultModel;
        if ([result.mess isEqualToString:@"succ"]) {
            CATransition *transitionAnimation = [CATransition animation];
            transitionAnimation.duration = 0.5f;
            transitionAnimation.type = kCATransitionPush;
            if (sender.tag == kRCMainLikeTypeLike) {
                transitionAnimation.subtype = kCATransitionFromLeft;
            } else if (sender.tag == kRCMainLikeTypeUnlike) {
                transitionAnimation.subtype = kCATransitionFromRight;
            }
            [_likePhotoCollectionView.layer addAnimation:transitionAnimation forKey:kRCMainLikeActionAnimationKey];
            _currentIndex ++;
            //浏览完当前数据
            if (_currentIndex == 20) {
                NSLog(@"重新刷数据");
                [self loadData];
                _currentIndex = 0;
                return;
            }
            //刷新数据
            [_likePhotoCollectionView reloadData];
            [self reloadInfo];
            [_likePhotoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        } else {
            NSLog(@"Like/UnLike操作失败");
            [RCMBHUDTool showText:@"操作失败，请重新Like/UnLike" hideDelay:1];
        }
    } failure:^(NSError *error) {
        NSLog(@"服务器错误");
    }];
}


- (void)camaraButtonDidClick {
    NSLog(@"Menu");
}

- (void)editButtonDidClick {
    self.mainLikeEditCoverView.hidden = NO;
    self.mainLikeEditView.hidden = NO;
    
    _idTextView.text = [_idLabel.text substringFromIndex:3];
    _idTextView.selectedRange = NSMakeRange(0, _idTextView.text.length);
    [_idTextView becomeFirstResponder];
}

- (void)cancelButtonDidClick {
    self.mainLikeEditCoverView.hidden = YES;
    self.mainLikeEditView.hidden = YES;
    
    [_idTextView resignFirstResponder];
}

- (void)doneButtonDidClick {
    self.mainLikeEditCoverView.hidden = YES;
    self.mainLikeEditView.hidden = YES;
    
    [_idTextView resignFirstResponder];
    //发送请求
#warning 修改snapID
    _idLabel.text = [NSString stringWithFormat:@"ID:%@", _idTextView.text];
    CGSize size = [_idLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: _idLabel.font} context:nil].size;
    _editButton.frame = CGRectMake((kRCScreenWidth - 40) / 2 + size.width / 2 + 10 - (200 - (CGRectGetMaxY(_photoView.frame) + 10) - 10 + 10) / 2, CGRectGetMaxY(_photoView.frame) + 10, 200 - (CGRectGetMaxY(_photoView.frame) + 10) - 10, 200 - (CGRectGetMaxY(_photoView.frame) + 10) - 10);
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCMainLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRCMainLikeMenuTableViewCellIdentifer];
    if (indexPath.row == 0) {
        cell.showTitle = @"Show";
        cell.isMore = YES;
        cell.moreTitle = @"Boys";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 1) {
        cell.showTitle = @"Feedback";
        cell.isMore = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.row == 2) {
        cell.showTitle = @"Share";
        cell.isMore = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.row == 3) {
        cell.showTitle = @"Log out";
        cell.isMore = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self acquirePhotoCount:_userList[_currentIndex]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RCMainLikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRMainLikeCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    RCUserInfoModel *userInfo = _userList[_currentIndex];

    if (indexPath.item == 0) {
        cell.showImageURL = [NSURL URLWithString:userInfo.url1];
    } else if (indexPath.item == 1) {
        cell.showImageURL = [NSURL URLWithString:userInfo.url2];
    } else if (indexPath.item == 2) {
        cell.showImageURL = [NSURL URLWithString:userInfo.url3];
    }
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    RCUserInfoModel *userInfo = _userList[_currentIndex];
    _indexLabel.text = [NSString stringWithFormat:@"%d/%d", (int)(scrollView.contentOffset.x / (kRCScreenWidth - 40)) + 1, [self acquirePhotoCount:userInfo]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RCMainLikePhotoDetailViewController *mainLikePhotoDetailVc = [[RCMainLikePhotoDetailViewController alloc] init];
    mainLikePhotoDetailVc.selectedItem = indexPath.item;
    mainLikePhotoDetailVc.selectedUserInfo = _userList[_currentIndex];
    [self.navigationController pushViewController:mainLikePhotoDetailVc animated:YES];
}

@end
