//
//  Macros.h
//  FUPay
//
//  Created by 徐军 on 2017/11/9.
//  Copyright © 2017年 徐军. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef void(^OTSCompletionBlock)(id aResponseObject, NSError* anError);
////不同屏幕尺寸字体适配（320，568是因为效果图为IPHONE5 如果不是则根据实际情况修改）
//#define kScreenWidthRatio  (Main_Screen_Width / 750.0)
//#define kScreenHeightRatio (Main_Screen_Height / 1334.0)
//#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
//#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
//#define AdaptedFontSize(R)     CHINESE_SYSTEM(AdaptedWidth(R))

//ios11Scorllview的inset适配
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
if (@available(iOS 11.0,*))  {\
scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;\
} else {\
self.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \

// MainScreen Height&Width
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

//导航栏高度
#define TopBarHeight (Main_Screen_Height >= 812.0 ? 88 : 64)
//是否是X
#define ISIPHONEX (Main_Screen_Height >= 812.0 ? YES : NO)
//底部高度
#define BottomHeight (Main_Screen_Height >= 812.0 ? 34 : 0)
//statusbar高度
#define StatusBarHeight (Main_Screen_Height >= 812.0 ? 44 : 20)

// 小于IOS9
#define isLessIOS9                  ([[[UIDevice currentDevice]systemVersion]floatValue] <= 9.0)

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])

// 是否大于等于IOS7
#define isIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
// 是否IOS6
#define isIOS6                  ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0)
// 是否大于等于IOS8
#define isIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)
// 是否大于IOS9
#define isIOS9                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)
// 是否大于IOS11
#define isIOS11                 ([[[UIDevice currentDevice]systemVersion]floatValue] >=11.0)
// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//色值
#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

//AppDelegate对象
#define AppDelegateInstance [[UIApplication sharedApplication] delegate]
//一些缩写
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//获取图片资源
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//Library/Caches 文件路径
#define FilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])
//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//全局self弱引用
#define WEAK_SELF __weak typeof(self)weakSelf = self
//全局self强引用
#define STRONG_SELF __strong typeof(weakSelf)self = weakSelf

// 单例创建
#undef    AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once(&once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

