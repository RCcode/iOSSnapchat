
#import <UIKit/UIKit.h>

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

#define kRCWeak(obj) __weak typeof(obj) weak##obj = obj;

#define kAcquireUserDefaultAll \
NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];\
NSString *coutryID = [userDefault stringForKey:kRCUserDefaultCountryIDKey];\
NSString *cityID = [userDefault stringForKey:kRCUserDefaultCityIDKey];\
NSString *pushtoken = [userDefault stringForKey:kRCRemoteNotificationsKey];\
double longitude = [userDefault doubleForKey:kRCUserDefaultLongitudeKey];\
double latitude = [userDefault doubleForKey:kRCUserDefaultLatitudeKey]; \
NSString *usertoken = [userDefault stringForKey:kRCUserDefaultUserTokenKey];

#define kAcquireUserDefaultLocalInfo \
NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];\
NSString *coutryID = [userDefault stringForKey:kRCUserDefaultCountryIDKey];\
NSString *cityID = [userDefault stringForKey:kRCUserDefaultCityIDKey];\
NSString *pushtoken = [userDefault stringForKey:kRCRemoteNotificationsKey];\
double longitude = [userDefault doubleForKey:kRCUserDefaultLongitudeKey];\
double latitude = [userDefault doubleForKey:kRCUserDefaultLatitudeKey];

#define kAcquireUserDefaultUsertoken \
NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];\
NSString *usertoken = [userDefault stringForKey:kRCUserDefaultUserTokenKey];

#define IOS8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
#define IOS7 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)

#define kRCDefaultNacgationBarItemFrame CGRectMake(0, 0, 44, 44)
#define kRCDefaultNacgationBarTitleFrame CGRectMake(0, 0, 200, 44)
#define kRCDefaultNacgationBarTitleFont kRCBoldSystemFont(17)

#define kRCAdaptationHeight(height) ((height) * kRCScreenHeight / 1136)
#define kRCAdaptationWidth(width) ((width) * kRCScreenWidth / 640)

#define kRCScreenBounds [UIScreen mainScreen].bounds
#define kRCScreenWidth kRCScreenBounds.size.width
#define kRCScreenHeight kRCScreenBounds.size.height
#define kRCSystemFont(font) [UIFont systemFontOfSize:(font)]
#define kRCBoldSystemFont(font) [UIFont boldSystemFontOfSize:(font)]
#define kRCLocalizedString(string) NSLocalizedString((string), nil)
#define kRCImage(string) [UIImage imageNamed:(string)]
#define kRCRGBAColor(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
#define kRCSystemLightgray kRCRGBAColor(209, 209, 209, 1)
#define kRCDefaultBlue colorWithHexString(@"2dcfe3")
#define kRCDefaultWhite colorWithHexString(@"ffffff")
#define kRCDefaultPurple colorWithHexString(@"9b55a0")
#define kRCDefaultLightgray colorWithHexString(@"bcbcbc")
#define kRCDefaultBackWhiteColor colorWithHexString(@"fdfdfd")
#define kRCDefaultAlphaWhite kRCRGBAColor(255, 255, 255, 0.2)
#define kRCDefaultAlphaBlack kRCRGBAColor(0, 0, 0, 0.54)
#define kRCDefaultDarkAlphaBlack kRCRGBAColor(0, 0, 0, 0.87)

#define kRCIOSBd(px) px * 72 / 96

extern NSString *const kRCUserDefaultCountryIDKey;
extern NSString *const kRCUserDefaultCityIDKey;
extern NSString *const kRCUserDefaultLongitudeKey;
extern NSString *const kRCUserDefaultLatitudeKey;
extern NSString *const kRCApplicationFirstStartKey;
extern NSString *const kRCRemoteNotificationsKey;
extern NSString *const kRCUserDefaultUserTokenKey;
extern NSString *const kRCUserDefaultGenderKey;
extern NSString *const kRCUserDefaultCategoryKey;
extern NSString *const kRCSwitchRootVcNotificationStepKey;
extern NSString *const kRCSwitchRootVcNotificationVcKey;

extern NSString *const kRCCameraGalleryNotification;
extern NSString *const kRCSwitchRootVcNotification;

