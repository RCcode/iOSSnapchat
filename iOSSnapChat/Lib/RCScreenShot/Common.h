//
//  Common.h
//  FilterGrid
//
//  Created by herui on 4/9/14.
//  Copyright (c) 2014年 rcplatform. All rights reserved.
//

#ifndef FilterGrid_Common_h
#define FilterGrid_Common_h

//Kakao AppID\URL Schemes 见info.plist
#define kWXAppID @"wxd930ea5d5a258f4f"
#define kPPURL @"http://192.168.0.86:8076/AdlayoutBossWeb/platform/getRcAdvConrol.do"
#define MY_INTERSTITIAL_UNIT_ID @"ca-app-pub-6180558811783876/7313852942"

#pragma mark -

#define kMoreAppID 20077//
#define UmengAPPKey @"5406cfa4fd98c51a1c001d3b"
#define FlurryAppKey @"93RV33S89KDGH49H4GCG"

#define kAppID @"919861751"
#define kNoCropAppID @"878086629"
#define kAppStoreURLPre @"itms-apps://itunes.apple.com/app/id"
#define kAppStoreURL [NSString stringWithFormat:@"%@%@", kAppStoreURLPre, kAppID]
#define kNoCropAppStoreURL [NSString stringWithFormat:@"%@%@", kAppStoreURLPre, kNoCropAppID]
#define kAppStoreScoreURLPre @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id="
#define kAppStoreScoreURL [NSString stringWithFormat:@"%@%@", kAppStoreScoreURLPre, kAppID]

#define HTTP_BASEURL @"http://iosnocrop.rcplatformhk.net/IOSNoCropWeb/external/"
#define kPushURL @"http://iospush.rcplatformhk.net/IOSPushWeb/userinfo/regiUserInfo.do"

#define AdMobID @"ca-app-pub-3747943735238482/5328990653"
#define AdUrl @"http://ads.rcplatformhk.com/AdlayoutBossWeb/platform/getRcAppAdmob.do"

#define kFeedbackEmail @"rcplatform.help@gmail.com"

#define kShareHotTags @"Made with @filtergrid #FilterGrid"
#define kFollwUsAccount @"filtergrid"
#define kFollwUsURL @"http://www.instagram.com/filtergrid"

//通知key
static NSString *NNKEY_SCREENSHOT = @"screenshot notiKey";
static NSString *DICTKEY_SUBIMAGE = @"subImage dictKey";
static NSString *SELECT_PHOTOMARK = @"selectPhotoMark";
static NSString *TOUCH_PHOTOMARK = @"touchPhotoMark";
static NSString *IMAGE_CHANGED = @"changeImage";
static NSString *NNKEY_GETTHEBESTIMAGE = @"get the best image";
static NSString *NNKEY_SHOWPHOTOVC = @"show photo view controller";
static NSString *NNKEY_SHOWROOTVC = @"show root view controller";
static NSString *CLEAR_COLORVIEW = @"clearView";
static NSString *UDKEY_WATERMARKSWITCH = @"water mark switch";
static NSString *DEVICE_TOKEN = @"deviceToken";
static NSString *DELETE_MARK = @"delete_Mark";
static NSString *HAVEDOWNLOAD = @"HaveDownLoad";
static NSString *NNKEY_FILTER_FINISH = @"filterVC finish";
static NSString *DICTKEY_FILTER_IMAGE = @"filterVC finish image dictKey";
static NSString *UDKEY_ShareCount = @"shareCount";


static NSString *UDKEY_OutputResolutionType = @"OutputResolutionType";

//评论&分享解锁开关
static NSString *UDKEY_ReviewUnLock = @"reviewUnLock";
static NSString *UDKEY_ShareUnLock = @"shareUnLock";

static NSString *kDefaultTemplateFileName = @"tp_grid_1";

//NSLog开关
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif

//随机颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1]

//屏幕size
#define kWinSize [UIScreen mainScreen].bounds.size
#define kScreen3_5 (kWinSize.height < 568)
#define kScreen4_0 (kWinSize.height == 568)
#define kScreen4_7 (kWinSize.height == 667)
#define kScreen5_5 (kWinSize.height == 736)

#define iPhone44sPod ([[UIDevice currentModelVersion] isEqualToString:@"iPhone3,1"]||[[UIDevice currentModelVersion] isEqualToString:@"iPhone4,1"]||[[UIDevice currentModelVersion] isEqualToString:@"iPod5,1"])

#define kNavBarH 44
#define KTabBarH 49
#define kScreemWidth kWinSize.width
#define kScreemHeight kWinSize.height
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

#define kOutputViewWH 1080
#define kOutputViewWH44s 960

//导航栏标题文本属性
#define kNavTitleSize 18
#define kNavTitleFontName @"Prosto"

#define RGBA(int) [UIColor colorWithRed:((color >> 24) & 0xFF) / 255.0f \
                                  green:((color >> 16) & 0xFF) / 255.0f \
                                   blue:((color >> 8) & 0xFF) / 255.0f \
                                  alpha:((color) & 0xFF) / 255.0f];


#define ImageWrite2SandBox(image, fileName) [UIImageJPEGRepresentation(image, 0.8) writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName] atomically:YES]


//用户当前的语言环境
#define CURR_LANG   ([[NSLocale preferredLanguages] objectAtIndex:0])

//宽高比
typedef enum{
    kAspectRatio1_1 = 0,
    kAspectRatio3_4,
    kAspectRatio4_3,
    kAspectRatio9_16,
    kAspectRatio16_9,
    
    kAspectRatioTotalNumber
}AspectRatio;

//模板类型
typedef enum{
    kTemplateTypeGrid = 1,
    kTemplateTypeShape,
    kTemplateTypeSingle,
    kTemplateTypeTotalNumber
}TemplateType;

//调整图片参数
typedef struct{
    CGFloat brightness;        //亮度      -1 ~ 1     0
    CGFloat contrast;          //对比度   0.5 ~ 1.5    1
    CGFloat saturation;        //饱和度     0 ~ 2      1
    CGFloat colorTemperature;  //色温     0.5 ~ 2     1
    CGFloat sharpening;        //锐化       0 ~ 2     0
}AdjustImageParam;


typedef enum {
    NC_NORMAL_FILTER = 0,
    
//    NC_F1_FILTER,
//    NC_F2_FILTER,
//    NC_F3_FILTER,
//    NC_F4_FILTER,
//    NC_F5_FILTER,
//    NC_F6_FILTER,
//    NC_F7_FILTER,
//    NC_F8_FILTER,
//    NC_F9_FILTER,
//    NC_F10_FILTER,
//    NC_F11_FILTER,
//    NC_F12_FILTER,
//    NC_F13_FILTER,
//    NC_F14_FILTER,
//    NC_F15_FILTER,
//    NC_F16_FILTER,
//    NC_F17_FILTER,
    NC_F18_FILTER,
    NC_F19_FILTER,
    NC_F20_FILTER,
    NC_F21_FILTER,
    NC_F22_FILTER,
    NC_F23_FILTER,
    NC_F24_FILTER,
    NC_F25_FILTER,
    NC_F26_FILTER,
    NC_F27_FILTER,
    NC_F28_FILTER,
//    NC_F29_FILTER,
    NC_F30_FILTER,
    NC_F31_FILTER,
    NC_F32_FILTER,
    NC_F33_FILTER,
    NC_F34_FILTER,
    NC_F35_FILTER,
    NC_F36_FILTER,
    NC_F37_FILTER,
    NC_F38_FILTER,
    NC_F39_FILTER,
    NC_F40_FILTER,
    NC_F41_FILTER,
    NC_F42_FILTER,
    NC_F43_FILTER,
    NC_F44_FILTER,
    NC_F45_FILTER,
    NC_F46_FILTER,
    NC_F47_FILTER,
    NC_F48_FILTER,
    NC_F49_FILTER,
    NC_F50_FILTER,
    NC_F51_FILTER,
    NC_F52_FILTER,
    NC_F53_FILTER,
    NC_F54_FILTER,
    NC_F55_FILTER,
    NC_F56_FILTER,
    NC_F57_FILTER,
    NC_F58_FILTER,
    NC_F59_FILTER,
    NC_F60_FILTER,
    NC_F61_FILTER,
    NC_F62_FILTER,
    NC_F63_FILTER,
    NC_F64_FILTER,
    NC_F65_FILTER,
    NC_F66_FILTER,
    NC_F67_FILTER,
    NC_F68_FILTER,
    NC_F69_FILTER,
    NC_F70_FILTER,
    NC_F71_FILTER,
    NC_F72_FILTER,
    NC_F73_FILTER,
    NC_F74_FILTER,
    NC_F75_FILTER,
    NC_F76_FILTER,
    NC_F77_FILTER,
    NC_F78_FILTER,
    NC_F79_FILTER,
    NC_F80_FILTER,
    NC_F81_FILTER,
    NC_F82_FILTER,
    NC_F83_FILTER,
    NC_F84_FILTER,
    NC_F85_FILTER,
    NC_F86_FILTER,
    NC_F87_FILTER,
    NC_F88_FILTER,
    NC_F89_FILTER,
    NC_F90_FILTER,
    NC_F91_FILTER,
//    NC_F92_FILTER,
//    NC_F93_FILTER,
//    NC_F94_FILTER,

    NC_FILTER_TOTAL_NUMBER
    
} NCFilterType;


#endif
