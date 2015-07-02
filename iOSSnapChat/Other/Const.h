
#import <UIKit/UIKit.h>

//宏
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
#define kRCDefaultAlphaWhite kRCRGBAColor(255, 255, 255, 0.2)
#define kRCDefaultAlphaBlack kRCRGBAColor(0, 0, 0, 0.54)

#define kRCIOSBd(px) px * 72 / 96

//key
extern NSString *const kRCUserDefaultCountryIDKey;
extern NSString *const kRCUserDefaultCityIDKey;
extern NSString *const kRCUserDefaultLongitudeKey;
extern NSString *const kRCUserDefaultLatitudeKey;

extern NSString *const kRCApplicationFirstStartKey;
extern NSString *const kRCRemoteNotificationsKey;
extern NSString *const kRCUserDefaultUserTokenKey;
extern NSString *const kRCUserDefaultResgisterStepKey;
extern NSString *const kRCUserDefaultGenderKey;
extern NSString *const kRCUserDefaultCategoryKey;

extern NSString *const kRCSwitchRootVcNotificationStepKey;
extern NSString *const kRCSwitchRootVcNotificationVcKey;

//notification
extern NSString *const kRCCameraGalleryNotification;
extern NSString *const kRCSwitchRootVcNotification;