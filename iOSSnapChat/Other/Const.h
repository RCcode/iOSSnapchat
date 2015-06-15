
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

//常量宏
#define kRCSystemDefaultBlue kRCRGBAColor(30, 190, 205, 1)

//常量
extern NSString *const kRCUserDefaultCountryIDKey;
extern NSString *const kRCUserDefaultCityIDKey;
extern NSString *const kRCUserDefaultLongitudeKey;
extern NSString *const kRCUserDefaultLatitudeKey;

extern NSString *const kRCRemoteNotificationsKey;
extern NSString *const kRCUserDefaultUserTokenKey;

extern NSString *const kRCCameraGalleryNotification;